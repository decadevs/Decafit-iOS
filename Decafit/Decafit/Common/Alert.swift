//
//  Alert.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//
import UIKit
class Alert {
    static func showAlert(_ presenter: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
}
