import UIKit

class FitConfigViewController: UIViewController {
    static let shared =  FitConfigViewController()
    lazy var topImageView = TodaySessionView(isHidden: true)
    lazy var labelStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews:
                                [inputVCTitleLabel, inputVCSubTitleLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.contentHuggingPriority(for: .vertical)
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
        nextButton.addTarget(self, action: #selector(gotoStartWorkout),
                             for: .touchUpInside)
        backButton.addTarget(self, action: #selector(clickNavBackButton),
                             for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}
extension FitConfigViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    @objc func clickNavBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func gotoStartWorkout() {
        let screen = WorkoutViewController.getWorkoutView()
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension FitConfigViewController: UIGestureRecognizerDelegate {
    func setupNavigation() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        navbar.backgroundColor = .white
        backButton.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        navbar.addSubview(backButton)
        navigationController?.navigationBar.addSubview(navbar)

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.backButtonTitle = " "
        navigationItem.backButtonDisplayMode = .minimal
    }
}
extension FitConfigViewController {
    func setupSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height/1.6)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         labelStack,
                                                         setsTextField, repsTextField, nextButton])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fillProportionally))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalToConstant: view.frame.width-10),
            topImageView.heightAnchor.constraint(equalToConstant: 240),
            topImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelStack.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 15),
            labelStack.heightAnchor.constraint(equalToConstant: 45),
            labelStack.leadingAnchor.constraint(equalTo: setsTextField.leadingAnchor, constant: 0),
            setsTextField.heightAnchor.constraint(equalToConstant: 56),
            repsTextField.heightAnchor.constraint(equalToConstant: 56),
            nextButton.heightAnchor.constraint(equalToConstant: 64),
            setsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            repsTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            nextButton.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
}
