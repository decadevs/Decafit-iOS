import UIKit
final class LoginViewController: UIViewController {
    let auth = AuthManager.shared
    static var shared: LoginViewController?
    static func getViewController() -> LoginViewController {
        return shared ?? LoginViewController()
    }
    var textFields: [UITextField] {
        return [emailTextField, passwordTextField]
    }
    var socialButtons: [DecaButton] {
        return [googleButton, facebookButton, appleButton]
    }
    // Button actions
    func addButtonTarget() {
        socialButtons.forEach { $0.addTarget(self, action: #selector(auth.handleSocialLogin),
                                             for: .touchUpInside) }
        orangeSignUpLink.addTarget(self, action: #selector(toggleSignup), for: .touchUpInside)
        loginButton.addTarget(self,
                              action: #selector(handleLogin), for: .touchUpInside)
    }
    // Stacked Views
    lazy var textViewStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading,
                                spacing: 15, distribution: .equalSpacing))
       return stackview
    }()
    lazy var socialStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: socialButtons)
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: 40, distribution: .fillEqually))
       return stackview
    }()
    lazy var redirectToSignupStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [dontHaveAnAccountLabel, orangeSignUpLink])
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: nil, distribution: .fillProportionally))
       return stackview
    }()
    lazy var lineStack: DecaStack = {
        let stackview = DecaStack()
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: 15, distribution: .fillEqually))
        let line = UIProgressView()
        line.heightAnchor.constraint(equalToConstant: 1.2).isActive = true
        let line2 = UIProgressView()
        line2.heightAnchor.constraint(equalToConstant: 1.2).isActive = true
        stackview.addArrangedSubview(line)
        stackview.addArrangedSubview(signInWithLabel)
        stackview.addArrangedSubview(line2)
       return stackview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textFields.forEach { $0.delegate = self }
        setupKeyboardDismissRecognizer()
        setUpSubviews()
        addButtonTarget()
        auth.delegate = self 
    }
    let act = ActivityIndicator()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        act.removeFromSuperview()
        act.stopAnimating()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        act.removeFromSuperview()
        act.stopAnimating()
    }
}
