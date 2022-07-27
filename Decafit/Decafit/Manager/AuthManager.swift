//
//  AuthManager.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import Foundation
protocol AuthManagerDelegate: AnyObject {
    func didShowAlert(title: String, message: String)
}
final class AuthManager {
    static let shared = AuthManager()
    weak var alertDelegate: AuthManagerDelegate?
    public var isSignedIn: Bool {
        return false
    }
    public func signOut() {
    }
    @objc func handleGoogleLogin() {
    }
    @objc func handleFBLogin() {
    }
    @objc func handleAppleLogin() {
    }
    @objc func handleTextChange() {
    }
    public func register(email: String, password: String,
                         fullName: String, phoneNumber: String,
                         completion: @escaping (Bool) -> Void) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty,
                !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
                !phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8 else {
            return
        }
        // send http request
        guard let url = URL(string: "www.google.com") else { return }
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
            alertDelegate?.didShowAlert(title: "OOPS!", message: "Something went wrong! try again.")
            return
        }
        let task = URLSession.shared.dataTask(with: request) {[self] (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                alertDelegate?.didShowAlert(
                    title: "Error!",
                    message: "Could not successfully register user. Please try again later.")
                print("Error=\(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let userId = parseJSON["id"] as? String
                    let accessToken = parseJSON["token"] as? String
                    if ((userId?.isEmpty) != nil) || ((accessToken?.isEmpty) != nil) {
                        alertDelegate?.didShowAlert(
                            title: "OOPS!",
                            message: "Could not successfully register user. Please try again later.")
                        print("Error=\(String(describing: error))")
                        return
                    } else {
                        alertDelegate?.didShowAlert(
                            title: "OOPS!",
                            message: "Successfully registered user. Check your email for the verification link.")
                    }
                } else {
                    alertDelegate?.didShowAlert(
                        title: "OOPS!",
                        message: "Could not successfully register user. Please try again later.")
                }
            } catch {
                alertDelegate?.didShowAlert(
                    title: "OOPS!",
                    message: "Could not successfully register user. Please try again later.")
            }
        }
        task.resume()
    }
}
