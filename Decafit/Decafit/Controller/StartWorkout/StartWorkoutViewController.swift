import UIKit

class StartWorkoutViewController: UIViewController {
    static var shared: StartWorkoutViewController?
    static func getWorkoutView() -> StartWorkoutViewController {
        return shared ?? StartWorkoutViewController()
    }
    let data = DataManager.shared
    var pvc = PopoverViewController()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(StartWorkoutCell.self,
                      forCellReuseIdentifier: StartWorkoutCell.identifier)
        return view
    }()
    lazy var topView: WorkoutPageTopview = {
       let view = WorkoutPageTopview()
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
        pvc.dismissCompletion = {
            self.view.removeOverlay()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pvc.dismissCompletion = {
            self.view.removeOverlay()
        }
    }
}
extension StartWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.getWorkoutData().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: StartWorkoutCell.identifier, for: indexPath)
                as? StartWorkoutCell else { return UITableViewCell()}
        cell.configure(with: data.getWorkoutData()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        displayModal()
    }
}
extension StartWorkoutViewController: UIGestureRecognizerDelegate {
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.popViewController(animated: true)
    }
    @objc func workoutButtonTapped() {
        startWorkoutButton.setTitle(Constants.continueWorkout, for: .normal)
        let firstIndex = tableView.indexPathsForVisibleRows?.first
        let firstRow = tableView.cellForRow(at: firstIndex!) as? StartWorkoutCell
        firstRow?.completeButton.isHidden = false
        let secondIndex = tableView.indexPathsForVisibleRows?[1]
        let secondRow = tableView.cellForRow(at: secondIndex!) as? StartWorkoutCell
        secondRow?.completeButton.setTitle(Constants.incompleteText, for: .normal)
        secondRow?.completeButton.setTitleColor(DecaColor.red.color, for: .normal)
        secondRow?.completeButton.backgroundColor = DecaColor.lightRed.color
        secondRow?.progressbar.isHidden = false
        secondRow?.progressbar.progress = 0.4
        secondRow?.completeButton.isHidden = false
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
    func displayModal() {
        view.addoverlay(color: .black, alpha: 0.6)
        self.modalPresentationStyle = .popover
        self.present(pvc, animated: true, completion: nil)
    }
}
