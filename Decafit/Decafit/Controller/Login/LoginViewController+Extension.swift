//
//  LoginViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import Foundation
import UIKit

extension LoginViewController {
    func setUpSubviews() {
//        [topImageView, textViewStack, signInWithLabel, socialStack, redirectToSignupStack].forEach {view.addSubview($0)}
        
        let parentStack = UIStackView(arrangedSubviews: [topImageView, signInStack, textViewStack, lineStack, socialStack, redirectToSignupStack])
        parentStack.axis = .vertical
        parentStack.alignment = .center
        parentStack.distribution = .fill
        parentStack.spacing = 20
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parentStack)
        
        NSLayoutConstraint.activate([
//            topImageView.heightAnchor.constraint(equalToConstant: 120),

            
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
