import UIKit
protocol StartWorkoutViewControllerDelegate: AnyObject {
    func didDisplaySelectedCell(image: String, title: String, duration: String)
}
class WorkoutViewController: UIViewController {
    static var shared: WorkoutViewController?
    static func getWorkoutView() -> WorkoutViewController {
        return shared ?? WorkoutViewController()
    }
    let data = DataManager.shared
    var detailsView = ModalViewController()
    weak var delegate: StartWorkoutViewControllerDelegate?
    lazy var tableView: UITableView = {
        let view = UITableView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
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
        navigationController?.navigationBar.topItem?.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.removeOverlay()
        detailsView.dismissCompletion = {
            self.view.removeOverlay()
        }
    }
}
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.getWorkoutData().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WorkoutCell.identifier, for: indexPath)
                as? WorkoutCell else { return UITableViewCell()}
        cell.configure(with: data.getWorkoutData()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = data.getWorkoutData()[indexPath.row]
        let image = selectedCell.image
        let title = selectedCell.exerciseName
        let duration = selectedCell.duration
        
        detailsView.titleText = title
        detailsView.imageName = image
        detailsView.modalPresentationStyle = .popover
        present(detailsView, animated: true, completion: nil)
        view.addoverlay(color: .black, alpha: 0.6)
        delegate?.didDisplaySelectedCell(image: image, title: title, duration: duration)
    }
}
extension WorkoutViewController: UIGestureRecognizerDelegate {
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
    }
    @objc func workoutButtonTapped() {
        startWorkoutButton.setTitle(Constants.continueWorkout, for: .normal)
//        let firstIndex = tableView.indexPathsForVisibleRows?.first
//        let firstRow = tableView.cellForRow(at: firstIndex!) as? StartWorkoutCell
//        firstRow?.completeButton.isHidden = false
//        let secondIndex = tableView.indexPathsForVisibleRows?[1]
//        let secondRow = tableView.cellForRow(at: secondIndex!) as? StartWorkoutCell
//        secondRow?.completeButton.setTitle(Constants.incompleteText, for: .normal)
//        secondRow?.completeButton.setTitleColor(DecaColor.red.color, for: .normal)
//        secondRow?.completeButton.backgroundColor = DecaColor.lightRed.color
//        secondRow?.progressbar.isHidden = false
//        secondRow?.progressbar.progress = 0.4
//        secondRow?.completeButton.isHidden = false
        
        // move to the next when nextbutton is clicked on the exercise page
        // Back button on all the exercises leads to workout list
        // When exercise is started, and you click the back button, that pauses the exercise, and
        // Shows the incomplete tag on the table
        // When exercise is completed before back button is clicked, show the complete tag on the table
        // [topImageView, exerciseName, progressBar, timerLabel,
        // stepsTakenView, pauseResumeButton,nextWorkoutButton, backButton]
        
        let exerciseVC = ExerciseViewController()
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
