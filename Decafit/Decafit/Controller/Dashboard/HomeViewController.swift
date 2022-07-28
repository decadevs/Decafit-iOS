//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var navigationBar: UINavigationBar = {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: view.frame.size.width, height: 100))
        navbar.barTintColor = .white
        let notificationIcon = UIBarButtonItem(
            image: UIImage(named: "bell-icon"),
            style: .plain, target: self, action: nil)
        let profileIcon = UIBarButtonItem(
            image: UIImage(named: "bell-icon"),
            style: .plain, target: self, action: nil)
        let navigationItem = UINavigationItem(title: "Good morning")
        navigationItem.leftBarButtonItem = profileIcon
        navigationItem.rightBarButtonItem = notificationIcon
        navbar.items = [navigationItem]
        return navbar
    }()
    lazy var today = TodaySessionView()
    lazy var focusArea = FocusAreaView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
}
extension HomeViewController {
    func setupSubviews() {
        [navigationBar, today, focusArea].forEach { view.addSubview($0)}
        NSLayoutConstraint.activate([
            today.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            today.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            today.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            focusArea.topAnchor.constraint(equalTo: today.bottomAnchor, constant: 10),
            focusArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            focusArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}
