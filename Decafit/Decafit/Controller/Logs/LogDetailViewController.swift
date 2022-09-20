//
//  LogDetailViewController.swift
//  Decafit
//
//  Created by Decagon on 16/09/2022.
//

import UIKit

class LogDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "Log Details"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .red 
    }

}
