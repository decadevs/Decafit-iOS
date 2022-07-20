//
//  SignupViewController.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
    }
    
    // MARK: - Image View
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "signup-img")
        imageView.contentMode = .scaleAspectFill
        imageView.addSubview(createPlanLabel)
        return imageView
    }()
    
    // MARK: - Title field
    lazy var titleField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.text = "Sign up"
        textField.font = customFont(size: 24, font: .poppinsMedium)
        textField.textAlignment = .left
        textField.tintColor = CustomColor.decafitBlack.color
        textField.isEnabled = false
        return textField
    }()
    
    // MARK: - FullnameTextField
    lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.placeholder = "Full name"
        textField.font = customFont(size: 16, font: .poppinsRegular)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = CustomColor.decafitGray.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - PhoneNumberTextField
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.placeholder = "Phone number"
        textField.font = customFont(size: 16, font: .poppinsRegular)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = CustomColor.decafitGray.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - EmailTextField
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.placeholder = "Email address"
        textField.font = customFont(size: 16, font: .poppinsRegular)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = CustomColor.decafitGray.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - PasswordTextField
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.placeholder = "Password"
        textField.font = customFont(size: 16, font: .poppinsRegular)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CustomColor.decafitGray.color.cgColor
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.rightViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - ConfirmPasswordTextField
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.placeholder = "Confirm password"
        textField.font = customFont(size: 16, font: .poppinsRegular)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CustomColor.decafitGray.color.cgColor
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.rightViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - SignupButton
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = customFont(size: 24, font: .ubuntuMedium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.backgroundColor = CustomColor.decafitPurple.color
        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Social Login Buttons
    lazy var googleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = CustomColor.decafitGray.color.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        button.setImage(UIImage(named: "google-logo"), for: .normal)
        button.layer.cornerRadius = 3
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fb-img"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = CustomColor.decafitGray.color.cgColor
        button.layer.cornerRadius = 3
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var appleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        button.setImage(UIImage(named: "apple-img"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = CustomColor.decafitGray.color.cgColor
        button.layer.cornerRadius = 3
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Sign in orange CTA Button
    lazy var orangeSignInLink: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = customFont(size: 16, font: .poppinsRegular)
        button.setTitleColor( CustomColor.decafitOrange.color , for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(toggleLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LABELS
    var createPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create a \nfitness/nutrition plan"
        label.font = customFont(size: 32, font: .poppinsMedium)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    var signInWithLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  Or sign in with  "
        label.font = customFont(size: 13, font: .poppinsMedium)
        label.textColor = CustomColor.decafitGray.color
        return label
    }()
    
    var alreadyHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an account? "
        label.font = customFont(size: 16, font: .poppinsMedium)
        label.textColor = CustomColor.decafitBlack.color
        return label
    }()
    
    // MARK: - Stack Views
    lazy var topViewStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .fill
        stackview.axis = .horizontal
        stackview.addArrangedSubview(topImageView)
       return stackview
    }()
    
    lazy var signInStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .leading
        stackview.axis = .horizontal
        stackview.addArrangedSubview(titleField)
       return stackview
    }()
    
    lazy var textViewStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .leading
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 20
        stackview.addArrangedSubview(fullNameTextField)
        stackview.addArrangedSubview(phoneNumberTextField)
        stackview.addArrangedSubview(emailTextField)
        stackview.addArrangedSubview(passwordTextField)
        stackview.addArrangedSubview(confirmPasswordTextField)
        stackview.addArrangedSubview(signUpButton)
       return stackview
    }()
    
    lazy var socialStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 35
        stackview.addArrangedSubview(googleButton)
        stackview.addArrangedSubview(facebookButton)
        stackview.addArrangedSubview(appleButton)
       return stackview
    }()
    
    lazy var redirectToSigninStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.addArrangedSubview(alreadyHaveAnAccountLabel)
        stackview.addArrangedSubview(orangeSignInLink)
       return stackview
    }()
    
    lazy var lineStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 20
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

