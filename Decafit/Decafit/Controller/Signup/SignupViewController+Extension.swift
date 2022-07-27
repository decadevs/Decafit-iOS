//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit
extension SignupViewController: AuthManagerDelegate {
    func didShowAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension SignupViewController {
    @objc func toggleToLogin() {
        let screen = LoginViewController()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    @objc func handleSignup() {
        guard let fullName = fullNameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else {
            didShowAlert(title: "Error!", message: "All fields are required!")
            return
        }
        if password != confirmPassword {
            didShowAlert(title: "Error!", message: "Passwords do not match!")
            return
        }
        // Start activity indicator
        let signupActivityIndicator = UIActivityIndicatorView(style: .medium)
        signupActivityIndicator.center = view.center
        signupActivityIndicator.hidesWhenStopped = false
        signupActivityIndicator.startAnimating()
        view.addSubview(signupActivityIndicator)
        AuthManager.shared.register(email: email, password: password,
                                    fullName: fullName, phoneNumber: phoneNumber) { [weak self] _ in
            removeActivityIndicator(activityIndicator: signupActivityIndicator)
            DispatchQueue.main.async {
                let nextView = LoginViewController()
                nextView.modalPresentationStyle = .fullScreen
                self?.present(nextView, animated: true)
            }
//            switch result {
//            case success:
//                DispatchQueue.main.async {
//                    let nextView = LoginViewController()
//                    nextView.modalPresentationStyle = .fullScreen
//                    self?.present(nextView, animated: true)
//                }
//            case failure:
//                print("There was an error signin in...")
//            }
        }
    }
}
extension SignupViewController {
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height+50)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews:
                                        [topViewStack, signInStack, textViewStack,
                                         lineStack, socialStack, redirectToSigninStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fill))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = contentViewSize
        scrollView.showsHorizontalScrollIndicator = true
        view.addSubview(scrollView)
        scrollView.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.heightAnchor.constraint(equalToConstant: 120),
            topViewStack.bottomAnchor.constraint(equalTo: signInStack.topAnchor, constant: -130),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 56),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.heightAnchor.constraint(equalToConstant: 64),
            titleField.heightAnchor.constraint(equalToConstant: 45),
            fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            createPlanLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 60)
        ])
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
