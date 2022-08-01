//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    @objc func toggleLogin() {
        let screen = LoginViewController.getLoginView()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    @objc func handleUserRegistration() {
        guard let fullName = fullNameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else {
            displayAlertMessage(title: "Error!", message: "All fields are required!")
            return
        }
        if password != confirmPassword {
            displayAlertMessage(title: "Error!", message: "Passwords do not match!")
            return
        }
        print(fullName, phoneNumber, email)
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
        var textFields: [UITextField] {
            return [fullNameTextField, phoneNumberTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        }
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func setupKeyboardDismissRecognizer(){
            let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(self.dismissKeyboard))
            self.view.addGestureRecognizer(tapRecognizer)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
