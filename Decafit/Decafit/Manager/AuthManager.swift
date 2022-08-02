//
//  AuthManager.swift
//  Decafit
//
//  Created by Decagon on 19/07/2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    public var isSignedIn: Bool {
        return true 
    }
    @objc public func signUp() {
    }
    public func signOut() {
    }
    @objc func handleUserLogin() {
    }
    @objc func handleGoogleLogin() {
    }
    @objc func handleFBLogin() {
    }
    @objc func handleAppleLogin() {
    }
    @objc func handleTextChange() {
    }
}
