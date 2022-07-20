//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    func setUpSubviews() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        let parentStack = UIStackView(arrangedSubviews: [topImageView, signInStack, textViewStack, lineStack, socialStack, redirectToSignupStack])
        parentStack.axis = .vertical
        parentStack.alignment = .center
        parentStack.distribution = .fill
        parentStack.spacing = 20
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(parentStack)
        
        NSLayoutConstraint.activate([
//            topImageView.heightAnchor.constraint(equalToConstant: 120),

            
            parentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            parentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            parentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            [fullNameTextField, phoneNumberTextField, emailTextField, passwordTextField, confirmPasswordTextField, signInButton, titleField].forEach {$0.heightAnchor.constraint(equalToConstant: 56)}
            
            fullNameTextField.heightAnchor.constraint(equalToConstant: 56),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            signInButton.heightAnchor.constraint(equalToConstant: 64),
            titleField.heightAnchor.constraint(equalToConstant: 45),
            
            fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            
            createPlanLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 35),
            createPlanLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -50),


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
