//
//  SignupViewController+Extension.swift
//  Decafit
//
//  Created by Decagon on 20/07/2022.
//

import UIKit

extension SignupViewController {
    @objc func toggleToLogin() {
        let screen = LoginViewController()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true)
    }
    func displayAlert(_ message: String) {
        let alertMessage = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        present(alertMessage, animated: true, completion: nil)
    }
    @objc func handleUserRegistration() {
        let fullName = fullNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        if fullName.isEmpty || phoneNumber.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            displayAlert("All fields are required!")
            return
        }
        if password != confirmPassword {
            displayAlert("Passwords do not match!")
            return
        }
        // Start activity indicator
        let signupActivityIndicator = UIActivityIndicatorView(style: .medium)
        signupActivityIndicator.center = view.center
        signupActivityIndicator.hidesWhenStopped = false
        signupActivityIndicator.startAnimating()
        view.addSubview(signupActivityIndicator)
        // send http request
        guard let url = URL(string: "") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let postString = ["fullName": fullName, "phoneNumber": phoneNumber,
                          "email": email, "password": password] as [String: String]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayAlert("Something went wrong! try again.")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            removeActivityIndicator(activityIndicator: signupActivityIndicator)
            if error != nil {
                self.displayAlert("Could not successfully register user. Please try again later.")
                print("Error=\(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let userId = parseJSON["id"] as? String
                    let accessToken = parseJSON["token"] as? String
                    if(((userId?.isEmpty) != nil) || ((accessToken?.isEmpty) != nil)) {
                        self.displayAlert("Could not successfully register user. Please try again later.")
                        print("Error=\(String(describing: error))")
                        return
                    } else {
                        self.displayAlert("Successfully registered user. Check your email for the verification link.")
                        self.present(LoginViewController(), animated: true, completion: nil)
                    }
                } else {
                    self.displayAlert("Could not successfully register user. Please try again later.")
                }
            } catch {
                self.displayAlert("Could not successfully register user. Please try again later.")
            }
        }
        task.resume()
    }
}

extension SignupViewController {
    func setUpSubviews() {
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height+50)
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews:
                                        [topViewStack, signInStack, textViewStack,
                                         lineStack, socialStack, redirectToSigninStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 20, distribution: .fill))
            stackView.frame.size = contentViewSize
            return stackView
        }()
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = contentViewSize
        scrollView.showsHorizontalScrollIndicator = true
        view.addSubview(scrollView)
        scrollView.addSubview(parentStack)
        NSLayoutConstraint.activate([
            topImageView.heightAnchor.constraint(equalToConstant: 120),
            topViewStack.bottomAnchor.constraint(equalTo: signInStack.topAnchor, constant: -130),
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
            createPlanLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            createPlanLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 60)
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
