//
//  LoginViewController.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    let auth = AuthManager.shared
    static var shared: LoginViewController?
    static func getViewController() -> LoginViewController {
        return shared ?? LoginViewController()
    }
    let defaults = UserDefaults.standard
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
        orangeSignUpLink.tag = 2
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
}
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
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
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
            // Save the UserIdentifier in the keychain
            let home = homeVC
            // home.userID = userIdentifier
//            view.window?.rootViewController = home
        default:
            break
        }
        
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Login with apple failed!")
    }

}
