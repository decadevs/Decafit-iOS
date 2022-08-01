//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    static let shared = HomeViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: view.bounds.width, height: 100))
        let item = UINavigationItem(title: "Home")
        navbar.items = [item]
        view.addSubview(navbar)
    }
}
