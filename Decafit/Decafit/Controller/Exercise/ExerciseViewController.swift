import UIKit
import RealmSwift

class ExerciseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var exerciseView = ExerciseView()
    let realm = try! Realm()
    let data = DataManager.shared
    let realmDb = StorageManager.shared
    let defaults = UserDefaults.standard
    let viewModel = ExerciseViewModel()
    
    typealias WorkoutData = GetWorkoutReportQuery.Data.ReportWorkout.Workout
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    var workoutExercisesList = [WorkoutData.Exercise]()
    var savedExercisesList = [ReportExcerciseProgressInput]()
    var selectedWorkoutid: String?
    weak var delegate: ExerciseVCDelegate?
    var currentExerciseId: String?

    var currentIndex: IndexPath = [0, 0]
    var lastIndex: IndexPath = [0, 0]
    var pauseTime: TimeInterval?
    var selectedWorkoutIndex: Int?
    
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
   
    func getExercises() {
        guard let selectedWorkoutId = selectedWorkoutid else { fatalError() }
        data.getExerciseList(workoutId: selectedWorkoutId)
        data.exerciseCompletion = { [weak self] result in
            DispatchQueue.main.async {
                self?.exercises = result
                self?.collectionView.reloadData()
                self?.viewModel.filteredExercisesReport()

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
        return viewModel.filteredExerciseArr.count > 0 ? viewModel.filteredExerciseArr.count : viewModel.exerciseRow.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExerciseCell.identifier,
                for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }

        if viewModel.exerciseRow.count < 1 {
            Alert.showAlert(self, title: "Done", message: "You have completed this workout")
            navigationController?.popViewController(animated: true)
        }
        // get filtered array from view model and use as data source
        let exercise = viewModel.exerciseRow[indexPath.item]

        cell.configure(with: exercise)
        cell.exerciseCellDelegate = self
        currentExerciseId = exercise.id
 
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
//
//        defaults.set(currentWorkoutReport.reps, forKey: UserDefaultKeys.repsTracker)
//        defaults.set(currentWorkoutReport.sets, forKey: UserDefaultKeys.setsTracker)
//
        let setsTracker = Double().setsTracker
        let repsTracker = Int().repsTracker
        
        exerciseView.repsProgressTag.setTitle("\(repsTracker/viewModel.currentWorkoutReport.reps)", for: .normal)

        return cell
               
    }
 
    func restartTimer() {
        let timeLeft = TimeInterval(endTime)
        
        exerciseView.nextExerciseButton.setTitle(Constants.repeatExercise, for: .normal)
        exerciseView.repsProgressTag.setTitle(viewModel.nextExerciseBtnTitle, for: .normal)
        
        exerciseView.isFirstTimerClick = true
        let timer = DecaTimer(timeLabel: exerciseView.timerLabel, timeLeft: timeLeft)
        timer.resetTimer(timeLeft: timeLeft)
        exerciseView.timer = timer

        let progressCircle = ProgressCircle()
        exerciseView.progressCircle.setProgress(duration: timeLeft)
        exerciseView.progressCircle = progressCircle
        
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
                restartTimer()
                collectionView.reloadData()

                self.collectionView.scrollToItem(at: repeatIndex, at: .left, animated: true)
                exerciseView.pauseResumeButton.setTitle("Restart", for: .normal)
                
                collectionView.reloadData()

                repsTracker -= 1
                defaults.set(repsTracker, forKey: UserDefaultKeys.repsTracker)
                
                print("Repeating exercise repsTracker", repsTracker)

            default:
                self.collectionView.scrollToItem(at: currentIndex, at: .left, animated: true)
                
                if currentIndex.row == viewModel.exerciseRow.count - 1 {
                    exerciseView.nextExerciseButton.setTitle(Constants.endWorkout, for: .normal)
                }
            }
        default:
            switch setsTracker > 1 {
            case true:
                self.collectionView.scrollToItem(at: firstIndex, at: .left, animated: true)
                restartTimer()

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
