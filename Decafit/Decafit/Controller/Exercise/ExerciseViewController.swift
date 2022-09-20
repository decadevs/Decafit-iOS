import UIKit
import RealmSwift

class ExerciseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var exerciseView = ExerciseView()
    let realm = try! Realm()
    let data = DataManager.shared
    let realmDb = StorageManager.shared
    let defaults = UserDefaults.standard
    
    var selectedWorkoutid: String?
    weak var delegate: ExerciseVCDelegate?
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    var exerciseRow = [WorkoutListQuery.Data.Workout.Exercise]()
    var filteredExerciseArr = [WorkoutListQuery.Data.Workout.Exercise]()
    var completedExerciseArr = [WorkoutListQuery.Data.Workout.Exercise]()

    var currentIndex: IndexPath = [0, 0]
    var lastIndex: IndexPath = [0, 0]
    var pauseTime: TimeInterval?
    var selectedWorkoutIndex: Int?
    var currentExerciseId: String?
        
    typealias WorkoutData = GetWorkoutReportQuery.Data.ReportWorkout.Workout
    var workoutExercisesList = [WorkoutData.Exercise]()
    var savedExercisesList = [ReportExcerciseProgressInput]()
    
    var currentWorkoutReport: DbWorkout {
        guard let selectedWorkoutId = selectedWorkoutid else { fatalError() }
        return realmDb.getWorkout(workoutId: selectedWorkoutId)
    }
    
    var currentExerciseReport: DbExercise {
        guard let currentExerciseID = currentExerciseId else { fatalError() }
        return realmDb.getExercise(exerciseId: currentExerciseID)
    }
    
    var endTime: Double {
        guard let selectedWorkoutId = selectedWorkoutid else { fatalError() }
        let num = realmDb.getWorkout(workoutId: selectedWorkoutId).time
        return Double(num)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        getExercises()
        ExerciseCell().exerciseCellDelegate = self
        
        let repsTracker = Double().repsTracker
        exerciseView.repsProgressTag.setTitle("\(repsTracker/endTime)", for: .normal)
        
        // fetch report from cache and populate array
        data.workoutReportCacheCompletion = { [weak self] data in
            self?.workoutExercisesList = data.reportWorkout?.workouts?.exercises ?? []
        }
        
//        if completedExerciseArr.count == exercises.count {
//            print("completedExerciseArr", completedExerciseArr)
//            // exercises are completed
//            Alert.showAlert(self, title: "Done", message: "You have completed this workout!")
//            navigationController?.popViewController(animated: true)
//        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(ExerciseCell.self,
                             forCellWithReuseIdentifier: ExerciseCell.identifier)
        return view
    }()
    
    func filterExercisesReport() {
        // loop through the exercises, check for those incomplete
        // add them to a new array, present that array
        let exercisesReport = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == selectedWorkoutid ?? "0" })
        print("exercises", exercises)
        if exercisesReport.count > 0 {
            for each in exercisesReport {
                if each.exerciseCompleted == true {
                    print("exercise completed", each)

                    let completedExercises = exercises.filter({ $0.id == each.exerciseId })
                    print("completedExercises", completedExercises)
                    completedExerciseArr.append(contentsOf: completedExercises)
                    print("completedExerciseArr", completedExerciseArr)
                } else {
                    print("exercise not completed", each)

                    let filteredExercises = exercises.filter({ $0.id == each.exerciseId })
                    print("filteredExercises", filteredExercises)
                    filteredExerciseArr.append(contentsOf: filteredExercises)
                    print("filteredExerciseArr", filteredExerciseArr)
                }
            }
            exerciseRow = filteredExerciseArr
        } else {
            exerciseRow = exercises
        }
        
    }
    
    func getExercises() {
        guard let selectedWorkoutId = selectedWorkoutid else { fatalError() }
        data.getExerciseList(workoutId: selectedWorkoutId)
//        data.fetchWorkoutReportFromCache(userId: view.getUserID(), workoutId: selectedWorkoutId)
        data.exerciseCompletion = { [weak self] result in
            DispatchQueue.main.async {
                self?.exercises = result
                self?.collectionView.reloadData()
                self?.filterExercisesReport()

            }
        }
    }
    func clickNavBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
        updateReportInCacheAndServer()
        
    }

}
// MARK: - DATA SOURCE
extension ExerciseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredExerciseArr.count > 0 ? filteredExerciseArr.count : exerciseRow.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExerciseCell.identifier,
                for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }

        if exerciseRow.count < 1 {
            print("No more exercises")
            Alert.showAlert(self, title: "Done", message: "You have completed this workout")
            navigationController?.popViewController(animated: true)
        }
        let exercise = exerciseRow[indexPath.item]

        cell.configure(with: exercise)
        cell.exerciseCellDelegate = self
        currentExerciseId = exercise.id
        print("currentExerciseId ", currentExerciseId ?? "")
 
        let stepcell = cell.exerciseView
        switch exercise.title {
        case "run":
            stepcell.progressCircle.isHidden = true
            stepcell.stepsTakenView.isHidden = false
            stepcell.timerLabel.isHidden = true
            stepcell.pauseResumeButton.tag = Tags.stepcell
            stepcell.displaySteps()
        default:
            stepcell.progressCircle.isHidden = false
            stepcell.stepsTakenView.isHidden = true
            stepcell.timerLabel.isHidden = false
        }

        let timeLeft = TimeInterval(endTime)
        let timeLeft2 = TimeInterval(currentExerciseReport.limit) ?? 11
        let endTime2 = Date().addingTimeInterval(timeLeft2)
        
        switch currentExerciseReport.started {
        case true:
            cell.exerciseView.timerLabel.text = endTime2.timeIntervalSinceNow.time
            cell.timer?.timeLeft = timeLeft2
        default:
            cell.exerciseView.timerLabel.text = view.inputTimeAsInterval
            cell.timer?.timeLeft = timeLeft
        }

        defaults.set(currentWorkoutReport.reps, forKey: UserDefaultKeys.repsTracker)
        defaults.set(currentWorkoutReport.sets, forKey: UserDefaultKeys.setsTracker)
        let setsTracker = Double().setsTracker
        let repsTracker = Int().repsTracker
        
        exerciseView.repsProgressTag.setTitle("\(repsTracker/currentWorkoutReport.reps)", for: .normal)
        
        if indexPath.row == exerciseRow.count - 1 {
            if setsTracker < 2 {
                cell.exerciseView.nextExerciseButton.setTitle(Constants.endWorkout, for: .normal)
            } else {
                cell.exerciseView.nextExerciseButton.setTitle(Constants.repeatWorkout, for: .normal)
                
            }
        }

        return cell
               
    }
 
    func resetTimer() {
        var repsTracker = Int().repsTracker

        let timeLeft = TimeInterval(endTime)
        exerciseView.timer?.invalidate()
        exerciseView.timer?.timeLeft = timeLeft

        let timer = DecaTimer(timeLabel: exerciseView.timerLabel, timeLeft: timeLeft)
        exerciseView.timer = timer

        let progressCircle = ProgressCircle()
        progressCircle.pauseAnimation()
        progressCircle.setProgress(duration: timeLeft)
        exerciseView.progressCircle = progressCircle
        
        exerciseView.pauseResumeButton.setTitle(Constants.start, for: .normal)
        exerciseView.nextExerciseButton.setTitle(Constants.repeatExercise, for: .normal)
        exerciseView.repsProgressTag.setTitle("\(repsTracker) Of \(currentWorkoutReport.reps) Reps", for: .normal)
        
//        collectionView.reloadData()

    }
}

extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    // MARK: - SCROLL VIEW
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var factor: CGFloat = 0.5
        if velocity.x < 0 {
            factor = -factor
        }
        let pageWidth: Float = Float(self.view.bounds.width)
        let minSpace: Float = 10.0
        var cellToSwipe: Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5) + Double(factor)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        }
        if cellToSwipe < Double(exercises.count) {
            currentIndex = IndexPath(row: Int(cellToSwipe), section: 0)
            lastIndex = IndexPath(row: Int(cellToSwipe), section: 0)
        } else {
            lastIndex = IndexPath(row: Int(cellToSwipe), section: 0)

        }

        var repsTracker = Int().repsTracker
        var setsTracker = Int().setsTracker
        let repeatIndex: IndexPath = IndexPath(row: Int(cellToSwipe)-1, section: 0)
        let firstIndex: IndexPath = IndexPath(row: 0, section: 0)
        
        switch lastIndex.row < exercises.count {
        case true:
            switch repsTracker > 1 {
            case true:
                self.collectionView.scrollToItem(at: repeatIndex, at: .left, animated: true)
                resetTimer()
                
                repsTracker -= 1
                defaults.set(repsTracker, forKey: UserDefaultKeys.repsTracker)
                
//                collectionView.reloadData()

                print("Repeating exercise repsTracker", repsTracker)

            default:
                self.collectionView.scrollToItem(at: currentIndex, at: .left, animated: true)
            }
        default:
            switch setsTracker > 1 {
            case true:
                self.collectionView.scrollToItem(at: firstIndex, at: .left, animated: true)
                resetTimer()
                
                setsTracker -= 1
                defaults.set(setsTracker, forKey: UserDefaultKeys.setsTracker)
                
                print("Sets Tracker ", setsTracker)
                updateReportInCacheAndServer()
            default:
                exerciseView.nextExerciseButton.setTitle(Constants.endWorkout, for: .normal)
                Alert.showDialog(self, title: "Exit Workout?", message: "Do you want to exit workout?", firstAction: "Exit", secondAction: "Continue")
                Alert.firstActionComplete = { [weak self] in
                    self?.updateReportInCacheAndServer()
                    self?.navigationController?.popToRootViewController(animated: true)
                }
                Alert.secondActionComplete = { [weak self] in
                    self?.navigationController?.popViewController(animated: true)

                }
            }
        } // End Switch

    }

}
