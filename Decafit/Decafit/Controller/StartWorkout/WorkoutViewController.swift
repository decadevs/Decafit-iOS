import UIKit
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
    lazy var topView: WorkoutTopView = {
       let view = WorkoutTopView()
        view.workoutTopviewBackButton.addTarget(self, action: #selector(clickNavBackButton), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [topView, tableView, startWorkoutButton].forEach { view.addSubview($0)}
        startWorkoutButton.addTarget(self, action: #selector(workoutButtonTapped), for: .touchUpInside)
        setupSubviews()
        setupNavigation()
        getExercises()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.removeOverlay()
        detailsView.dismissCompletion = {
            self.view.removeOverlay()
        }
    }
    
    func getExercises() {
        data.getExerciseList(workoutId: selectedId ?? "")
        data.exerciseCompletion = { [self] result in
            self.exercises = result
            tableView.reloadData()
            topView.titleLabel.text = "\(self.exercises.count) Exercises"
        }
    }
    
}

// MARK: - Exercise View Controller Delegate
extension WorkoutViewController: ExerciseVCDelegate {
    func reload() {
        checkExerciseCompletion()
        tableView.reloadData()
    }
    func checkExerciseCompletion() {
//        if isComplete {
//            WorkoutCell().completeButton.isHidden = false
//        } else {
//            showIncompleteBtn(row: , progress: )
//        }
    }
    func showIncompleteBtn(row: IndexPath, progress: Float) {
        // let firstIndex = tableView.indexPathsForVisibleRows?.first
        let row = tableView.cellForRow(at: row) as? WorkoutCell
        row?.completeButton.isHidden = false
        row?.completeButton.setTitle(Constants.incompleteText, for: .normal)
        row?.completeButton.setTitleColor(DecaColor.red.color, for: .normal)
        row?.completeButton.backgroundColor = DecaColor.lightRed.color
        row?.progressbar.isHidden = false
        row?.progressbar.progress = progress
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

        let exercises = exercises[indexPath.row]
        cell.configure(with: exercises)
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
    func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backButtonTitle = " "
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.isHidden = true
    }
    @objc func workoutButtonTapped() {
        startWorkoutButton.setTitle(Constants.continueWorkout, for: .normal)
        let exerciseVC = ExerciseViewController()
        exerciseVC.exerciseDelegate = self
        exerciseVC.selectedWorkoutId = selectedId
        self.navigationController?.pushViewController(exerciseVC, animated: true)
    }
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
