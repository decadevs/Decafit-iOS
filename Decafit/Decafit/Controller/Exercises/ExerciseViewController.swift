import UIKit
protocol ExerciseVCDelegate: AnyObject {
    func reload()
    func didDisplayCompleteButton()
}
class ExerciseViewController: UIViewController {
    var exerciseView = ExerciseView()
    
    let data = DataManager.shared
    let defaults = UserDefaults.standard
    var selectedWorkoutId: String?
    weak var delegate: ExerciseVCDelegate?
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()
    
    var currentIndex: IndexPath = [0, 0]
    var pauseTime: TimeInterval?
    var selectedWorkoutIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        getExercises()
        selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)
                
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
        data.exerciseCompletion = { [self] result in
            DispatchQueue.main.async {
                exercises = result
                collectionView.reloadData()
            }
        }
    }
}
extension ExerciseViewController: UIGestureRecognizerDelegate, ExerciseCellDelegate {
    func startExercise() {
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }
        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[currentIndex.row]
        thisExercise?.started = true 
    }
    
    func gotoNextExercise(pauseTime: TimeInterval) {
        let endTime = defaults.double(forKey: UserDefaultKeys.time)
        self.pauseTime = pauseTime
        
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }
        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[currentIndex.row]
        thisExercise?.excerciseId = exercises[currentIndex.row].id
        thisExercise?.type = exercises[currentIndex.row].type.rawValue
        
        var completed = thisExercise?.completed
        if pauseTime > 0 {
            completed = false
            thisExercise?.paused = true
            self.pauseTime = pauseTime
            thisExercise?.limit = "\(pauseTime)"
        } else {
            completed = true
            thisExercise?.paused = false
            thisExercise?.limit = "\(pauseTime)"
        }

        thisExercise?.limit = "\(pauseTime)"
        thisExercise?.progress = Float(pauseTime/endTime)

        delegate?.reload()
        scrollViewWillEndDragging(collectionView, withVelocity: collectionView.contentOffset, targetContentOffset: &collectionView.contentOffset)
    }
    
    func updatePauseTime(pauseTime: TimeInterval, resumeTapped: Bool) {
        self.pauseTime = pauseTime
        let endTime = defaults.double(forKey: UserDefaultKeys.time)
        
        guard let selectedWorkoutIndex = selectedWorkoutIndex else { fatalError() }

        var thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[currentIndex.row]
        
        if thisExercise?.started == true {
            if resumeTapped == false {
                
                thisExercise?.paused = true
                thisExercise?.progress = Float(pauseTime/endTime)
                thisExercise?.excerciseId = exercises[currentIndex.row].id
                thisExercise?.type = exercises[currentIndex.row].type.rawValue
                thisExercise?.limit = "\(String(describing: self.pauseTime))"

            }
        }
                
    }
    func updateReportInCacheAndServer() {
        let selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)
        let thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[currentIndex.row]
        
        let exid = thisExercise?.excerciseId
        let type = thisExercise?.type ?? ""
        let limit = thisExercise?.limit
        let progress = thisExercise?.progress ?? 0.5
        let paused = thisExercise?.paused
        let completed = thisExercise?.completed
        
        guard let selectedId = selectedWorkoutId else { fatalError() }
        let reps = defaults.integer(forKey: UserDefaultKeys.reps)
        let sets = defaults.integer(forKey: UserDefaultKeys.sets)
        let count = defaults.integer(forKey: UserDefaultKeys.count)
        guard let time = defaults.string(forKey: UserDefaultKeys.time) else { fatalError()}

        // update server reports
        let savedexercises = ReportExcerciseProgressInput(excerciseId: exid, type: EnumType(rawValue: type), paused: paused, limit: limit, completed: completed, progress: Int(progress*10))
        let reportWorkoutInput = ReportWorkoutInput(workoutId: selectedId, workoutReps: reps, workoutSet: sets, workoutTime: time, workoutCount: count, exercises: [savedexercises])
        data.createReport(userId: view.getUserID(), workout: reportWorkoutInput)
    }

    func clickNavBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
        
        delegate?.didDisplayCompleteButton()
        
        // update report in cache and server
        updateReportInCacheAndServer()
        
    }
}
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
        
        let stepcell = cell.exerciseView
        if exercise.title == "Skipping" ||
            exercise.title == "Running" ||
            exercise.title == "Jogging" {
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
        
        let selectedWorkoutIndex = defaults.integer(forKey: UserDefaultKeys.selectedWorkoutIndex)

        let thisExercise = defaults.workoutReport?.workout[selectedWorkoutIndex].exerciseArr?[indexPath.row]
        
        let timeLeft = TimeInterval(defaults.double(forKey: UserDefaultKeys.time))
        let endTime = Date().addingTimeInterval(timeLeft)
        
        let timeLeft2 = TimeInterval(thisExercise?.limit ?? "15") ?? 15
        let endTime2 = Date().addingTimeInterval(timeLeft2)

        if thisExercise?.started == true {
            cell.exerciseView.timerLabel.text = endTime2.timeIntervalSinceNow.time
            cell.timer?.timeLeft = timeLeft2
        } else {
            cell.exerciseView.timerLabel.text = endTime.timeIntervalSinceNow.time
            cell.timer?.timeLeft = timeLeft

        }
        
        return cell
    }
}
extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
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
        self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        currentIndex = indexPath
    }
}
