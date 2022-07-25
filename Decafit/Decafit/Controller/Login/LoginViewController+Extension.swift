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
        let screen = SignupViewController()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
}

extension LoginViewController {
    func setUpSubviews() {
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView, signInStack,
                                                         textViewStack, lineStack,
                                                         socialStack, redirectToSignupStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fill))
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            parentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            parentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            parentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
            titleField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            trackFitnessLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 35),
            trackFitnessLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            trackFitnessLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -50)
        ])
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
