import UIKit

extension SignupViewController: AuthManagerDelegate {
    func didShowAlert(title: String, message: String) {
        Alert.showAlert(self, title: title,
                        message: message)
    }
    @objc func toggleLogin() {
//        toggleAuthScreens(orangeSignInLink)
        self.dismiss(animated: true, completion: nil)
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
        let user = User(fullName: fullName, email: email,
                        phoneNumber: phoneNumber, password: password)
        HUD.show(status: "Signing you up...")
        auth.register(user: user)
        auth.successcomplete = { [weak self] output in
            if output {
                self?.didShowNextScreen()
            }
        }
    }
}

extension SignupViewController {
    func setUpSubviews() {
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews:
                                        [signupTopImageView, textViewStack, signUpButton,
                                         lineStack, socialStack, redirectToSigninStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 10, distribution: .fill))
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            parentStack.widthAnchor.constraint(equalTo: view.widthAnchor),
//            parentStack.heightAnchor.constraint(equalTo: view.heightAnchor),
            parentStack.topAnchor.constraint(equalTo: view.topAnchor),
            parentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            signupTopImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
//            signupTopImageView.heightAnchor.constraint(equalTo: parentStack.heightAnchor, multiplier: 0.25),
            signupTopImageView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: 0),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 51),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 51),
            emailTextField.heightAnchor.constraint(equalToConstant: 51),
            passwordTextField.heightAnchor.constraint(equalToConstant: 51),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 51),
            fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            createPlanLabel.leadingAnchor.constraint(equalTo: signupTopImageView.leadingAnchor, constant: 30),
            createPlanLabel.trailingAnchor.constraint(equalTo: signupTopImageView.trailingAnchor, constant: -15),
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
    func didShowNextScreen() {
        let title = "Success!"
        let message = "You have been successfully registered. Check your email inbox for your verification token."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                let login = LoginViewController.getViewController()
                login.modalPresentationStyle = .fullScreen
                self.present(login, animated: true, completion: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
