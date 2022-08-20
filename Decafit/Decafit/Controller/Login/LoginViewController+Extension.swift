import UIKit
import KeychainSwift

extension LoginViewController: AuthManagerDelegate {
    @objc func toggleSignup() {
        self.dismiss(animated: true, completion: nil)
    }
    func didShowAlert(title: String, message: String) {
        Alert.showAlert(self, title: title,
                        message: message)
    }
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {
            Alert.showAlert(self, title: Constants.alertTitleError, message: Constants.blankTextFieldError)
            return
        }
        if password.count < 7 || !email.contains("@") {
            Alert.showAlert(self, title: Constants.alertTitleError, message: Constants.incorrectInputError)
            return
        }
        let user = LoginInput(email: email, password: password)
        HUD.show(status: "Signing you in...")
        auth.login(user: user)
        auth.successcomplete = { _ in
            let home = HomeViewController.getHomeView()
            home.modalPresentationStyle = .fullScreen
            self.present(home, animated: true, completion: nil)
        }
    }
}
extension LoginViewController {
    func setUpSubviews() {
        let parentStack: DecaStack = {
            let stackView = DecaStack(arrangedSubviews: [topImageView,
                                                         textViewStack, lineStack,
                                                         socialStack, redirectToSignupStack])
            stackView.configure(with: DecaStackViewModel(
                                    axis: .vertical, alignment: .center,
                                    spacing: 15, distribution: .fill))
            return stackView
        }()
        view.addSubview(parentStack)
        NSLayoutConstraint.activate([
            parentStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            parentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            topImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            topImageView.topAnchor.constraint(equalTo: parentStack.topAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            trackFitnessLabel.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor, constant: 25),
            trackFitnessLabel.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor, constant: -40),
            trackFitnessLabel.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -20)
        ])
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
