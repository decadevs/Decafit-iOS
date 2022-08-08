//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    static var shared: HomeViewController?
    static func getHomeView() -> HomeViewController {
        return shared ?? HomeViewController()
    }
    lazy var todayView = TodaySessionView()
    lazy var focusAreaView: FocusAreaView = {
        let view = FocusAreaView()
        view.delegate = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigation()
    }
}
extension HomeViewController: FocusAreaViewDelegate {
    func didDisplayFitConfigScreen(_ screen: FitConfigViewController, image: UIImage?, title: String) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
    func setupNavigation() {
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        navbar.addSubview(CustomNavbar())
        navigationController?.navigationBar.addSubview(navbar)
        view.addSubview(navbar)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    func setupSubviews() {
        [todayView, focusAreaView].forEach { view.addSubview($0)}
        NSLayoutConstraint.activate([
            
            todayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            todayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            todayView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height * 0.3)),
            focusAreaView.topAnchor.constraint(equalTo: todayView.bottomAnchor, constant: 10),
            focusAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            focusAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            focusAreaView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height * 0.4))
        ])
    }
}
