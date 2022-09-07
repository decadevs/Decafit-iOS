import UIKit
protocol ExerciseVCDelegate: AnyObject {
    func reload()
    func didDisplayCompleteButton()
}
class ExerciseViewController: UIViewController, UIGestureRecognizerDelegate {
    var exerciseView = ExerciseView()
    
    let data = DataManager.shared
    let defaults = UserDefaults.standard
    var selectedWorkoutId: String?
    weak var delegate: ExerciseVCDelegate?
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    
    var currentIndex: IndexPath = [0, 0]
    var pauseTime: TimeInterval?
    var selectedWorkoutIndex: Int?
    var currentExerciseId: String?
    
    typealias WorkoutData = GetWorkoutReportQuery.Data.ReportWorkout.Workout
    var workoutExercisesList = [WorkoutData.Exercise]()
    var savedExercisesList = [ReportExcerciseProgressInput]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        getExercises()
        selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)
        
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
        data.getExerciseList(workoutId: selectedWorkoutId!)
        data.fetchWorkoutReportFromCache(userId: view.getUserID(), workoutId: selectedWorkoutId!)
        data.exerciseCompletion = { [weak self] result in
            DispatchQueue.main.async {
                self?.exercises = result
                self?.collectionView.reloadData()
            }
        }
    }
    func clickNavBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
        
        delegate?.didDisplayCompleteButton()
        updateReportInCacheAndServer()
        
    }
    
}
// MARK: - DATA SOURCE

extension ExerciseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExerciseCell.identifier,
                for: indexPath) as? ExerciseCell else { return UICollectionViewCell() }
        let exercise = exercises[indexPath.item]
        cell.configure(with: exercise)
        cell.exerciseCellDelegate = self
        currentExerciseId = exercise.id
        
        let stepcell = cell.exerciseView
        if exercise.type == .count {
            stepcell.progressCircle.isHidden = true
            stepcell.stepsTakenView.isHidden = false
            stepcell.timerLabel.isHidden = true
            stepcell.pauseResumeButton.tag = Tags.stepcell
            stepcell.displaySteps()
        } else {
            stepcell.progressCircle.isHidden = false
            stepcell.stepsTakenView.isHidden = true
            stepcell.timerLabel.isHidden = false
            
        }
        
        if indexPath.row == exercises.count - 1 {
            cell.exerciseView.nextWorkoutButton.setTitle("End Workout", for: .normal)
        }
        
        let selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)

        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row].excerciseId = exercise.id
        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row].type = exercise.type.rawValue
        defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row].limit = String(describing: pauseTime)
        
        let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))        
        let timeLeft2 = TimeInterval(defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row].limit ?? "15") ?? 15
        let endTime2 = Date().addingTimeInterval(timeLeft2)

        if defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row].started == true {
            cell.exerciseView.timerLabel.text = endTime2.timeIntervalSinceNow.time
            cell.timer?.timeLeft = timeLeft2
        } else {
            cell.exerciseView.timerLabel.text = view.inputTimeAsInterval
            cell.timer?.timeLeft = timeLeft

        }
        
        let rep = defaults.integer(forKey: UserDefaultKeys.reps)
        defaults.set(rep, forKey: UserDefaultKeys.repsTracker)
        
        let set = defaults.integer(forKey: UserDefaultKeys.sets)
        defaults.set(set, forKey: UserDefaultKeys.setsTracker)
        
        return cell
               
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
        } else if cellToSwipe >= Double(exercises.count) {
            cellToSwipe = Double(exercises.count) - Double(1)
        }
        let indexPath: IndexPath = IndexPath(row: Int(cellToSwipe), section: 0)
        currentIndex = indexPath

//        updateReportInCacheAndServer()

        var setsTracker = defaults.integer(forKey: UserDefaultKeys.setsTracker)
        var repsTracker = defaults.integer(forKey: UserDefaultKeys.repsTracker)
        let repeatIndex: IndexPath = IndexPath(row: Int(cellToSwipe)-1, section: 0)
        let firstIndex: IndexPath = IndexPath(row: 0, section: 0)
        
        print("Row count", indexPath.row)
        if indexPath.row < exercises.count {
            if repsTracker > 1 {
                exerciseView.nextWorkoutButton.setTitle(Constants.repeatWorkout, for: .normal)
                
                self.collectionView.scrollToItem(at: repeatIndex, at: .left, animated: true)
                print("Repeating exercise")
  
                // change button title
                // restart timer
                exerciseView.timer?.invalidate()
                let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))
                exerciseView.timer?.timeLeft = timeLeft
                exerciseView.progressCircle.setProgress(duration: timeLeft)
                exerciseView.pauseResumeButton.setTitle(Constants.start, for: .normal)
                
                // trigger a reload
            
                repsTracker -= 1
                defaults.set(repsTracker, forKey: "repsTracker")
                print("repsTracker", repsTracker)
//                collectionView.reloadData()
                
            } else {
                
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }

        } else {
            
            if setsTracker > 1 {
                setsTracker -= 1
                defaults.set(setsTracker, forKey: "setsTracker")
                
                updateReportInCacheAndServer()
                self.collectionView.scrollToItem(at: firstIndex, at: .left, animated: true)
                
            } else {
                exerciseView.nextWorkoutButton.setTitle("The End", for: .normal)

                Alert.showDialog(self, title: "Exit Workout?", message: "Do you want to exit workout?", firstAction: "Exit", secondAction: "Continue") { [weak self] output in

                    if output {
                        self?.updateReportInCacheAndServer()
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }

            }
            
        }

    }

}
