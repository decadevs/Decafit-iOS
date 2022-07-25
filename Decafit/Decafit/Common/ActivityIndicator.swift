//
//  ActivityIndicator.swift
//  Decafit
//
//  Created by Decagon on 25/07/2022.
//

import UIKit
func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
    DispatchQueue.main.async {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
