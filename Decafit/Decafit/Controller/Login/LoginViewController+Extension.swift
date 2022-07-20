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
        
        let parentStack = UIStackView(arrangedSubviews: [topImageView, textViewStack, signInWithLabel, socialStack, redirectToSignupStack])
        parentStack.axis = .vertical
        parentStack.alignment = .center
        parentStack.distribution = .fill
        parentStack.spacing = 30
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parentStack)
        
        NSLayoutConstraint.activate([
//            topImageView.heightAnchor.constraint(equalToConstant: 120),

            
            parentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            parentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            parentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            parentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            parentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            
//            parentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            parentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            parentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
