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
        navigationController?.pushViewController(screen, animated: true)
//        navigationController?.present(screen, animated: true)
//        present(screen, animated: true)
    }
}

extension SignupViewController {
    func setUpSubviews() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.width*2)
//        scrollView.contentSize = CGSize(width: scrollView.frame.width*2, height: scrollView.frame.width)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
//        [topImageView, signInStack, textViewStack, lineStack, socialStack, redirectToSigninStack].forEach {scrollView.addSubview($0)}
        
        let parentStack = UIStackView(arrangedSubviews: [topImageView, signInStack, textViewStack, lineStack, socialStack, redirectToSigninStack])
        parentStack.axis = .vertical
        parentStack.alignment = .center
        parentStack.distribution = .fill
        parentStack.spacing = 20
        parentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(parentStack)
        
        NSLayoutConstraint.activate([
//            topImageView.heightAnchor.constraint(equalToConstant: 120),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            parentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            parentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            
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
