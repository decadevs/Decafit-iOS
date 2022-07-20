//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    @objc func toggleLogin() {
        let screen = LoginViewController()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
}

extension SignupViewController {
    
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height+50)
        let scrollView = UIScrollView(frame: view.bounds)
        
        let parentStack = UIStackView(arrangedSubviews: [topViewStack, signInStack, textViewStack, lineStack, socialStack, redirectToSigninStack])
        parentStack.frame.size = contentViewSize
        parentStack.axis = .vertical
        parentStack.alignment = .center
        parentStack.distribution = .fill
        parentStack.spacing = 20

        scrollView.contentSize = contentViewSize
        scrollView.showsHorizontalScrollIndicator = true
        view.addSubview(scrollView)
        scrollView.addSubview(parentStack)
        
        NSLayoutConstraint.activate([
            topImageView.heightAnchor.constraint(equalToConstant: 120),
            topViewStack.bottomAnchor.constraint(equalTo: signInStack.topAnchor, constant: -130),
            
//            [fullNameTextField, phoneNumberTextField, emailTextField, passwordTextField, confirmPasswordTextField, signInButton, titleField].forEach {$0.heightAnchor.constraint(equalToConstant: 56)}
            
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
            
//            googleButton.widthAnchor.constraint(equalToConstant: 56),
//            facebookButton.widthAnchor.constraint(equalToConstant: 56),
//            appleButton.widthAnchor.constraint(equalToConstant: 56),
//            googleButton.heightAnchor.constraint(equalToConstant: 56),
//            facebookButton.heightAnchor.constraint(equalToConstant: 56),
//            appleButton.heightAnchor.constraint(equalToConstant: 56),
            
            createPlanLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 60),


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
