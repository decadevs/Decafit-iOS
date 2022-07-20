//
//  SceneDelegate.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
         guard let windowScene = scene as? UIWindowScene else {
             return
         }
        let initialViewController: UIViewController
//        let navigationViewController: UINavigationController = UINavigationController(rootViewController: LoginViewController())
//        navigationViewController.navigationBar.isHidden = true

        
        let authManager = AuthManager.shared
        switch authManager.isSignedIn {
        case true:
            initialViewController = HomeViewController()
        case false:
            initialViewController = LoginViewController()
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

