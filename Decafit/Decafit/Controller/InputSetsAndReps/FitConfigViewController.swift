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
}
extension FitConfigViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    @objc func clickNavBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    func getConfigInput() {
        guard let reps = repsTextField.text, let sets = setsTextField.text, !reps.isEmpty, !sets.isEmpty else {
            Alert.showAlert(self, title: Constants.alertTitleError, message: Constants.blankTextFieldError)
            return
        }
        print(reps, sets)
    }
    @objc func gotoStartWorkout() {
//        getConfigInput()
        let screen = WorkoutViewController.getWorkoutView()
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
extension FitConfigViewController: UIGestureRecognizerDelegate {
    func setupNavigation() {
        let cview = UIView(frame: CGRect(x: 20, y: 40, width: 350, height: 50))
        cview.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.bottomAnchor.constraint(equalTo: cview.bottomAnchor).isActive = true
        view.addSubview(cview)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
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
