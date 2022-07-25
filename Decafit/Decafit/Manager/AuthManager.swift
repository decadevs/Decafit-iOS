//
//  AuthManager.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
//    private let auth = Auth.auth() - This is the auth function coming from the api 
    public var isSignedIn: Bool {
        return false
    }
    @objc public func signUp() {
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
    
//    public func signIn(email: String,
//                       password: String,
//                       completion: @escaping (Bool) -> Void) {
//        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
//                !password.trimmingCharacters(in: .whitespaces).isEmpty,
//              password.count >= 8 else {
//            return
//        }
//        auth.signIn(withEmail: email, password: password) { result, error in
//            guard result != nil,
//                    error == nil
//            else {
//                completion(false)
//                return
//            }
//            
//            let currentUser = result?.user
//            if let user = currentUser {
//                let uid = user.uid
//            }
//            completion(true)
//        }
//    }
    
}
