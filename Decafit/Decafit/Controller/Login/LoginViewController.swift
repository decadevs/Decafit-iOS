//
//  LoginViewController.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    static var shared: LoginViewController?
    static func getLoginView() -> LoginViewController {
        return shared ?? LoginViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupKeyboardDismissRecognizer()
        setUpSubviews()
    }
    // MARK: - Image View
    lazy var topImageView: DecaImageView = {
        let imageView = DecaImageView(frame: .zero)
        imageView.configure(with: DecaImageViewModel(
                                image: "fitness-img", contentMode: .scaleAspectFit,
                                tintColor: .white))
        imageView.addSubview(trackFitnessLabel)
        return imageView
    }()
    // MARK: - Title field
    var titleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 29, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Sign in", kerning: 0.5))
        label.textAlignment = .left
        return label
    }()
    // MARK: - EmailTextField
    lazy var emailTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "Email address", delegate: self,
                                font: decaFont(size: 16, font: .poppinsRegular),
                                backgroundColor: .clear,
                                tintColor: DecaColor.decafitBlack.color, borderWidth: 1, cornerRadius: 5,
                                borderColor: DecaColor.decafitGray.color.cgColor, isSecureEntry: false,
                                isEnabled: true, tarmic: false,
                                leftView: UIView(frame:
                                                    CGRect(x: 0, y: 0, width: 10, height: textField.frame.height)),
                                rightView: nil, leftViewMode: .always,
                                rightViewMode: nil))
        return textField
    }()
    // MARK: - PasswordTextField
    lazy var passwordTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "Password", delegate: self,
                                font: decaFont(size: 16, font: .poppinsRegular),
                                backgroundColor: .clear,
                                tintColor: nil, borderWidth: 1, cornerRadius: 5,
                                borderColor: DecaColor.decafitGray.color.cgColor, isSecureEntry: true,
                                isEnabled: true, tarmic: false,
                                leftView: UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height)),
                                rightView: UIView(frame: CGRect(x: 0, y: 0, width: 50,
                                                                height: textField.frame.height)), leftViewMode: .always,
                                rightViewMode: .always))
        return textField
    }()
    // MARK: - LoginButton
    var loginButton: DecaButton = {
        let button = createPurpleButton(title: "Sign In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    // MARK: - Social Login Buttons
    var googleButton: SocialButton = {
    let button = SocialButton(image: UIImage(named: "google-logo")!)
    button.addTarget(self, action: #selector(AuthManager.shared.handleGoogleLogin), for: .touchUpInside)
    return button
    }()
    var facebookButton: SocialButton = {
    let button = SocialButton(image: UIImage(named: "fb-img")!)
    button.addTarget(self, action: #selector(AuthManager.shared.handleFBLogin), for: .touchUpInside)
    return button
    }()
    var appleButton: SocialButton = {
    let button = SocialButton(image: UIImage(named: "apple-img")!)
    button.addTarget(self, action: #selector(AuthManager.shared.handleFBLogin), for: .touchUpInside)
    return button
    }()
    // MARK: - Sign Up orange CTA Button
    lazy var orangeSignUpLink: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(
                            title: "Sign up", font: decaFont(size: 16, font: .poppinsRegular),
                            backgroundColor: .clear,
                            titleColor: DecaColor.decafitOrange.color,
                            image: nil,
                            borderWidth: nil, cornerRadius: nil,
                            borderColor: DecaColor.decafitGray.color.cgColor,
                            contentEdgeInsets: nil,
                            isEnabled: true, tarmic: false))
        button.addTarget(self, action: #selector(toggleSignup), for: .touchUpInside)
        return button
    }()
    // MARK: - LABELS
    lazy var trackFitnessLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 38, font: .poppinsMedium), textColor: .white,
                            numberOfLines: 2, text: "Track \n your fitness", kerning: 1.3))
        return label
    }()
    lazy var signInWithLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 15, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                            text: " Or sign in with ", kerning: nil))
        return label
    }()
    lazy var dontHaveAnAccountLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                            text: "Don't have an account? ", kerning: nil))
        return label
    }()
    // MARK: - Stack Views
    lazy var textViewStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading,
                                spacing: 15, distribution: .equalSpacing))
       return stackview
    }()
    lazy var socialStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [googleButton, facebookButton, appleButton])
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
}
