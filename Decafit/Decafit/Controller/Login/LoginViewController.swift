//
//  LoginViewController.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        title = "Sign in"
        
        setUpSubviews()
    }
    
    // MARK: - Image View
    
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fitness-img")
        imageView.contentMode = .scaleAspectFill
        imageView.largeContentTitle = "Track your fitness"
        imageView.tintColor = .white
        return imageView
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
        textField.layer.borderColor = UIColor.gray.cgColor
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
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: textField.frame.height))
        textField.rightViewMode = .always
//        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - LoginButton
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = customFont(size: 14, font: .ubuntuMedium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.4031648636, green: 0.3810556829, blue: 0.658888042, alpha: 1)
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var textViewStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .leading
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 30
        stackview.addArrangedSubview(emailTextField)
        stackview.addArrangedSubview(passwordTextField)
        stackview.addArrangedSubview(loginButton)
        stackview.backgroundColor = .green
       return stackview
    }()
    
    // MARK: - Social Login Buttons
    lazy var googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(UIImage(named: "google-logo"), for: .normal)
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fb-img"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
//        button.isEnabled = true
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(UIImage(named: "apple-img"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var socialStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 30
        stackview.addArrangedSubview(googleButton)
        stackview.addArrangedSubview(facebookButton)
        stackview.addArrangedSubview(appleButton)
       return stackview
    }()
    
    // MARK: - LABELS
    var signInWithLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Or sign in with "
        label.font = customFont(size: 12, font: .poppinsMedium)
        label.textColor = #colorLiteral(red: 0.7126122117, green: 0.74427706, blue: 0.7983196378, alpha: 1)
        return label
    }()
    
    var dontHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account? "
        label.font = customFont(size: 16, font: .poppinsMedium)
        label.textColor = #colorLiteral(red: 0.1642587185, green: 0.1759757698, blue: 0.2050507069, alpha: 1)
        return label
    }()
    
    // MARK: - Sign Up Button
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = customFont(size: 16, font: .poppinsRegular)
        button.setTitleColor( #colorLiteral(red: 0.9505439401, green: 0.394153595, blue: 0.1895760596, alpha: 1) , for: .normal)
        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var redirectToSignupStack: UIStackView = {
       let stackview = UIStackView()
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        stackview.addArrangedSubview(dontHaveAnAccountLabel)
        stackview.addArrangedSubview(signUpButton)
       return stackview
    }()
    
    
    
}
