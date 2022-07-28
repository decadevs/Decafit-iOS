//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    @objc func toggleSignup() {
        let screen = SignupViewController.shared
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    func displayAlertMessage(_ message: String) {
    }
    @objc func handleUserRegistration() {
        let fullName = fullNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        if fullName.isEmpty || phoneNumber.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            displayAlertMessage("All fields are required!")
            return
        }
        if password != confirmPassword {
            displayAlertMessage("Passwords do not match!")
            return
        }
    }
}

extension SignupViewController {
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height-25)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews:
                                        [topImageView, textViewStack,
                                         lineStack, socialStack, redirectToSigninStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 10, distribution: .fill))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = contentViewSize
        scrollView.showsHorizontalScrollIndicator = true
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            topImageView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: -20),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 53),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 53),
            emailTextField.heightAnchor.constraint(equalToConstant: 53),
            passwordTextField.heightAnchor.constraint(equalToConstant: 53),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 53),
            signUpButton.heightAnchor.constraint(equalToConstant: 58),
            fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            createPlanLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -30)
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
