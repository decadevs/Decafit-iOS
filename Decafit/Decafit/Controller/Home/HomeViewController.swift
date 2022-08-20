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
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
}
extension HomeViewController: FocusAreaViewDelegate {
    func didDisplayFitConfigScreen(_ screen: FitConfigViewController, image: UIImage?, title: String) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    func setupNavigation() {
        let navbar = Navbar(frame: CGRect(x: 10, y: 25, width: 350, height: 80))
        navbar.backgroundColor = .white
        let menuBarItem = CustomNavView()
        navbar.addSubview(menuBarItem)
        
        let currWidth = menuBarItem.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        currWidth.isActive = true
        let currHeight = menuBarItem.heightAnchor.constraint(equalToConstant: 60)
        currHeight.isActive = true
        
        navigationController?.navigationBar.addSubview(navbar)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shouldRemoveShadow(true)
        navigationController?.navigationBar.barStyle = .default
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
