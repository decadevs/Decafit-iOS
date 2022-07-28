//
//  LoginViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import Foundation
import UIKit

extension LoginViewController {
    @objc func toggleSignup() {
        let screen = SignupViewController.shared
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {
            displayAlertMessage(title: "Error!", message: "All fields are required!")
            return
        }
        if password.count < 8 || !email.contains("@") {
            displayAlertMessage(title: "Error!", message: "Incorrect input")
            return
        }
        let home = HomeViewController.shared
        home.modalPresentationStyle = .fullScreen
        present(home, animated: true, completion: nil)
    }
}

extension LoginViewController {
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height-30)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         textViewStack, lineStack,
                                                         socialStack, redirectToSignupStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 15, distribution: .fill))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            topImageView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            trackFitnessLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 30),
            trackFitnessLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            trackFitnessLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -35)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var textFields: [UITextField] {
            return [emailTextField, passwordTextField]
        }
        if let selectedTextFieldIndex =
            textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
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
