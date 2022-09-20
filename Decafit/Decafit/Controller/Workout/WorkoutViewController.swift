import UIKit
import RealmSwift

class WorkoutViewController: UIViewController {
    static var shared: WorkoutViewController?
    static func getWorkoutView() -> WorkoutViewController {
        return shared ?? WorkoutViewController()
    }
  
    let data = DataManager.shared
    var detailsView = ModalViewController()
    let defaults = UserDefaults.standard
    var exercises = [WorkoutListQuery.Data.Workout.Exercise]()

    var selectedId: String?
    var currentIndex: IndexPath = [0, 0]
    var displayButtonCompletion: ((Int) -> Void)?
    var currentExerciseId: String?
    let realmDb = StorageManager.shared
    let home = HomeViewController.getHomeView()
    let realm = try! Realm()
    
    // MARK: - Current Workout report
    var currentWorkoutReport: DbWorkout {
        guard let selectedWorkoutId = selectedId else { fatalError() }
        return realmDb.getWorkout(workoutId: selectedWorkoutId)
    }
    
    var currentExerciseReport: DbExercise {
        return realmDb.getExercise(exerciseId: currentExerciseId ?? "0")
    }
    
    var endTime: Double {
        guard let selectedWorkoutId = selectedId else { fatalError() }
        let num = realmDb.getWorkout(workoutId: selectedWorkoutId).time
        return Double(num)!
    }
    // MARK: - Workout button enabled
    var isWorkoutBtnEnabled: Bool {
        switch startWorkoutButton.currentTitle {
        case Constants.workoutComplete:
            return false
        default:
            return true
        }
    }
    // MARK: - Workout Button Title
    var workoutBtnTitle: String {
        var title = ""
        let assocExercises = realmDb.fetchAllExercises().where({ $0.associatedWorkoutId == selectedId ?? "0" })
        assocExercises.forEach { exercise in
            if exercise.exerciseNotStarted == true {
                title = Constants.startWorkout
            } else if exercise.exerciseNotComplete == true {
                title = Constants.continueWorkout
            } else {
                title = Constants.workoutComplete
            }
        }
        return title
    }
    // MARK: - Get Exercises List
    func getExercises() {
        data.getExerciseList(workoutId: selectedId ?? "")
        data.exerciseCompletion = { [weak self] result in
            DispatchQueue.main.async {
                self?.exercises = result
                self?.tableView.reloadData()
                self?.topView.titleLabel.text = "\(self?.exercises.count ?? 0) Exercises"
            }
        }
    }
    // MARK: - Create Table View
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(WorkoutCell.self,
                      forCellReuseIdentifier: WorkoutCell.identifier)
        return view
    }()
    // MARK: - Create Top View
    
    lazy var topView: WorkoutTopView = {
       let view = WorkoutTopView()
        view.workoutTopviewBackButton.addTarget(self, action: #selector(clickNavBackButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Override ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [topView, tableView, startWorkoutButton].forEach { view.addSubview($0)}
        startWorkoutButton.addTarget(self, action: #selector(workoutButtonTapped), for: .touchUpInside)
        setupSubviews()
        setupNavigation()
        getExercises()
        
        showCompletionTag()
        
    }
    // MARK: - Override viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.removeOverlay()
        detailsView.dismissCompletion = {
            self.view.removeOverlay()
        }
        showCompletionTag()
        
        // start workout button title
        startWorkoutButton.isEnabled = isWorkoutBtnEnabled

    }
    // MARK: - Override viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .default

    }
    // MARK: - Status bar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Create StartWorkout Button
    lazy var startWorkoutButton: DecaButton = {
//        let button = DecaButton.createPurpleButton(title: workoutBtnTitle)
        let button = DecaButton.createPurpleButton(title: Constants.startWorkout)

        button.layer.shadowOffset = CGSize(width: 0, height: 8)
        button.layer.shadowOpacity = 0.1
        return button
    }()
 
}

// MARK: - Exercise View Controller Delegate

extension WorkoutViewController: ExerciseVCDelegate {
    func reloadData() {
        tableView.reloadData()
    }

 // MARK: - Show complete button
    func showCompletionTag() {
        guard let currentWorkoutId = selectedId else { return }
        guard let cell = tableView.cellForRow(at: currentIndex) as? WorkoutCell else { return }
        let exercise = realmDb.getExercise(exerciseId: currentExerciseId ?? "0")
        
        if exercise.exerciseNotStarted {
            cell.completeButton.isHidden = true
            displayButtonCompletion?(1)
            print("exercise not started 1")

        } else if exercise.exerciseCompleted {
            cell.completeButton.isHidden = false
            displayButtonCompletion?(2)
            print("exercise comleted 1")

        } else {
            cell.progressbar.progress = exercise.progress
            showIncompleteTag(cell: cell)
            displayButtonCompletion?(3)
            print("exercise incomplete 1")

        }

        tableView.reloadData()

    }
    
    func showIncompleteTag(cell: WorkoutCell) {
        cell.completeButton.isHidden = false
        cell.completeButton.setTitle(Constants.incompleteText, for: .normal)
        cell.completeButton.setTitleColor(DecaColor.red.color, for: .normal)
        cell.completeButton.backgroundColor = DecaColor.lightRed.color
        cell.progressbar.isHidden = false
//        cell.progressbar.progress = progress
    }

}
// MARK: - Table View Data Source
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WorkoutCell.identifier, for: indexPath)
                as? WorkoutCell else { return UITableViewCell()}
        currentIndex = indexPath
        let exercisesRow = exercises[indexPath.row]
        currentExerciseId = exercisesRow.id
        cell.configure(with: exercisesRow)
        
        // save exercises report in db
        switch realmDb.fetchAllExercises().contains(where: { $0.exerciseId == currentExerciseId }) {
        case true:
            print("it exists!")
        default:
            let exerc = DbExercise(exerciseId: currentExerciseId ?? "111", type: exercisesRow.type.rawValue, paused: false, completed: false, limit: "\(endTime)", progress: 0, started: false, dateExercised: Date(), associatedWorkoutId: selectedId ?? "0")
            realmDb.saveExercise(exerc)
        }
        
        // Show time and count in cell
        switch exercisesRow.type {
        case .time:
            cell.workoutDurationLabel.text = view.inputTimeAsInterval
        default:
            cell.workoutDurationLabel.text = "X\(currentWorkoutReport.count)"
        }

        if currentExerciseReport.exerciseCompleted {
            cell.completeButton.isHidden = false

        } else if currentExerciseReport.exerciseNotComplete {
            cell.progressbar.progress = currentExerciseReport.progress
            showIncompleteTag(cell: cell)

        } else {
            cell.completeButton.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = exercises[indexPath.row]
        let image = selectedCell.image
        let title = selectedCell.title
        let desc = selectedCell.description
        _ = selectedCell.type
        
        detailsView.titleText = title
        detailsView.imageName = image
        detailsView.desc = desc
        detailsView.modalPresentationStyle = .popover
        present(detailsView, animated: true, completion: nil)
        view.addoverlay(color: .black, alpha: 0.6)
    }
}
// MARK: - Gesture Recognizer Delegate
extension WorkoutViewController: UIGestureRecognizerDelegate {
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Navigation
    func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backButtonTitle = " "
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: - Workout Button Tapped
    @objc func workoutButtonTapped() {
        startWorkoutButton.setTitle(Constants.continueWorkout, for: .normal)
        let exerciseVC = ExerciseViewController()
        exerciseVC.delegate = self
        exerciseVC.selectedWorkoutid = selectedId
        
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
    // MARK: - Set Up Constraints
    func setupSubviews() {
        NSLayoutConstraint.activate([
            // topview
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 288),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            // tableview
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height*0.65)),
            startWorkoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.86),
            startWorkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            startWorkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
