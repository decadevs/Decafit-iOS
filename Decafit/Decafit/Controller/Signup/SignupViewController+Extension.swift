//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    @objc func toggleLogin() {
        toggleLoginSignup(self)
    }
    @objc func handleUserRegistration() {
        guard let fullName = fullNameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else {
            Alert.showAlert(self, title: Constants.alertTitleError,
                            message: Constants.blankTextFieldError)
            return
        }
        if password != confirmPassword {
            Alert.showAlert(self, title: Constants.alertTitleError,
                            message: Constants.passwordMismatchError)
            return
        }
        // Call auth sign in method here
        print(fullName, phoneNumber, email)
    }
}

extension SignupViewController {
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height-25)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews:
                                        [signupTopImageView, textViewStack,
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
            signupTopImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            signupTopImageView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: -20),
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
            createPlanLabel.leadingAnchor.constraint(equalTo: signupTopImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: signupTopImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: signupTopImageView.bottomAnchor, constant: -30)
        ])
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField),
           selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func setupKeyboardDismissRecognizer() {
            let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(self.dismissKeyboard))
            self.view.addGestureRecognizer(tapRecognizer)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
