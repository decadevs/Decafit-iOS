import UIKit
import AuthenticationServices
import KeychainSwift

final class SignupViewController: UIViewController {
    let auth = AuthManager.shared
    let keychain = KeychainSwift()
    
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
                            textColor: DecaColor.gray.color, numberOfLines: 1,
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
        
        appleSigninButton.addTarget(self, action: #selector(didTapAppleSignin), for: .touchUpInside)
        appleSigninButton.translatesAutoresizingMaskIntoConstraints = false
        appleSigninButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAppleButton(_:))))
        appleSigninButton.isUserInteractionEnabled = true
    }
    @objc func tapAppleButton(_ sender: UITapGestureRecognizer) {
        didTapAppleSignin()
    }
    // replace social stack with the apple button
    let appleSigninButton = ASAuthorizationAppleIDButton()
    @objc func didTapAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
extension SignupViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let token = appleIDCredential.identityToken
            let asp = ASPasswordCredential()
            let password = asp.password
            
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email)), \n Token is \(String(describing: token)), \n Password is \(password)")
            
            keychain.set(String(describing: token), forKey: AuthManager.loginKeychainKey)
            keychain.set(userIdentifier, forKey: Constants.userID)
            
            let home = homeVC
            view.window?.rootViewController = home
//        case let passwordCredential as ASPasswordCredential:
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            print("username \(username)   password \(password)") // use this information to verify the account from server and resume normal app flow
        default:
            break
            
        }
        
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Login with apple failed!")
    }

}
