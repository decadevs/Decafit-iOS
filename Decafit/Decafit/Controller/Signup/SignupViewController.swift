//
//  SignupViewController.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.

import UIKit

final class SignupViewController: UIViewController {
    static var shared: SignupViewController?
    static func getSignupView() -> SignupViewController {
        return shared ?? SignupViewController()
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
                                image: "signup-img", contentMode: .scaleAspectFit,
                                tintColor: .white))
        imageView.addSubview(createPlanLabel)
        return imageView
    }()
    // MARK: - Title field
    var titleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 29, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color,
                            numberOfLines: 1, text: "Sign up", kerning: 0.5))
        label.textAlignment = .left
        return label
    }()
    // MARK: - FullnameTextField
    lazy var fullNameTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "  Full name", delegate: self,
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
    // MARK: - PhoneNumberTextField
    lazy var phoneNumberTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "Phone number", delegate: self,
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
    // MARK: - EmailTextField
    lazy var emailTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "  Email address", delegate: self,
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
                                placeholder: "  Password", delegate: self,
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
    // MARK: - ConfirmPasswordTextField
    lazy var confirmPasswordTextField: DecaTextField = {
        let textField = DecaTextField()
        textField.configure(with: DecaTextFieldViewModel(
                                placeholder: "  Confirm password", delegate: self,
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
    // MARK: - SignupButton
    var signUpButton: DecaButton = {
        let button = createPurpleButton(title: "Sign up")
        button.addTarget(self, action: #selector(handleUserRegistration), for: .touchUpInside)
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
    lazy var orangeSignInLink: DecaButton = {
        let button = DecaButton()
        button.configure(with: DecaButtonViewModel(
                            title: "Sign in", font: decaFont(size: 16, font: .poppinsRegular),
                            backgroundColor: .clear,
                            titleColor: DecaColor.decafitOrange.color,
                            image: nil,
                            borderWidth: nil, cornerRadius: nil,
                            borderColor: nil,
                            contentEdgeInsets: nil,
                            isEnabled: true, tarmic: false))
        button.addTarget(self, action: #selector(toggleLogin), for: .touchUpInside)
        return button
    }()
    // MARK: - LABELS
    lazy var createPlanLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 28, font: .poppinsBold), textColor: .white,
                            numberOfLines: 2, text: "Create a \nfitness/nutrition plan", kerning: 1.4))
        return label
    }()
    lazy var signInWithLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 13, font: .poppinsMedium),
                            textColor: DecaColor.decafitGray.color, numberOfLines: 1,
                            text: "  Or sign in with  ", kerning: nil))
        return label
    }()
    lazy var alreadyHaveAnAccountLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 16, font: .poppinsMedium),
                            textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                            text: "Already have an account? ", kerning: nil))
        return label
    }()
    // MARK: - Stack Views
    lazy var textViewStack: DecaStack = {
       let stackview = DecaStack(arrangedSubviews: [titleLabel, fullNameTextField, phoneNumberTextField, emailTextField,
                                                    passwordTextField, confirmPasswordTextField, signUpButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .vertical, alignment: .leading ,
                                spacing: 0.1, distribution: .equalSpacing ))
       return stackview
    }()
    lazy var socialStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [googleButton, facebookButton, appleButton])
        stackview.configure(with: DecaStackViewModel(
                                axis: .horizontal, alignment: .center,
                                spacing: 35, distribution: .fillEqually))
       return stackview
    }()
    lazy var redirectToSigninStack: DecaStack = {
        let stackview = DecaStack(arrangedSubviews: [alreadyHaveAnAccountLabel, orangeSignInLink])
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
