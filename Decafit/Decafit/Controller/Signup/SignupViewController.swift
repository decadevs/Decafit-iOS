import UIKit

final class SignupViewController: UIViewController {
    let auth = AuthManager.shared
    static var shared: SignupViewController?
    static func getViewController() -> SignupViewController {
        return shared ?? SignupViewController()
    }
    // MARK: - Text Fields
    let fullNameTextField: DecaTextField =
        DecaTextField.createNormalTextField(text: Constants.fullname)
    let phoneNumberTextField: DecaTextField =
        DecaTextField.createNormalTextField(text: Constants.phone)
    let emailTextField: DecaTextField =
        DecaTextField.createNormalTextField(text: Constants.emailHolder)
    let passwordTextField: DecaTextField =
        DecaTextField.createSecureTextField(text: Constants.pswHolder)
    let confirmPasswordTextField: DecaTextField =
        DecaTextField.createSecureTextField(text: Constants.confirmPsw)
    var textFields: [UITextField] {
        return [fullNameTextField, phoneNumberTextField,
                emailTextField, passwordTextField, confirmPasswordTextField]
    }
    // MARK: - Buttons
    let googleButton = DecaButton.createSocialButton(image: Constants.googleImg)
    let facebookButton = DecaButton.createSocialButton(image: Constants.fbImg)
    let appleButton = DecaButton.createSocialButton(image: Constants.appleImg)
    let signUpButton = DecaButton.createPurpleButton(title: Constants.signUp)
    let orangeSignInLink = DecaButton.createOrangeButtonLink(title: Constants.signIn)
    var socialButtons: [DecaButton] {
        return [googleButton, facebookButton, appleButton]
    }
    func addButtonTarget() {
        socialButtons.forEach { $0.addTarget(self, action: #selector(auth.handleSocialLogin),
                                             for: .touchUpInside) }
        orangeSignInLink.addTarget(self, action: #selector(toggleLogin), for: .touchUpInside)
        orangeSignInLink.tag = Tags.orangeSignInLink
        signUpButton.addTarget(self, action: #selector(handleUserRegistration), for: .touchUpInside)
    }
    // MARK: - Labels
    let signInWithLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 13, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                            text: Constants.signinWith, kerning: nil))
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textFields.forEach { $0.delegate = self }
        setupKeyboardDismissRecognizer()
        setUpSubviews()
        addButtonTarget()
    }
    // MARK: - Stacked Views
    lazy var textViewStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews:
                                    [signupTitleLabel, fullNameTextField,
                                     phoneNumberTextField, emailTextField,
                                     passwordTextField, confirmPasswordTextField])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading ,
                                spacing: 10, distribution: .equalSpacing ))
       return stackview
    }()
    lazy var socialStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [googleButton, facebookButton,
                                                     appleButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: 35, distribution: .fillEqually))
       return stackview
    }()
    lazy var redirectToSigninStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [alreadyHaveAnAccountLabel,
                                                     orangeSignInLink])
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
}
