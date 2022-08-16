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
    let navbar = Navbar(frame: CGRect(x: 20, y: 20, width: 350, height: 80))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        let navbar = Navbar(frame: CGRect(x: 10, y: 10, width: 350, height: 80))
        let menuBarItem = CustomNavbar()
        navbar.addSubview(menuBarItem)
        
        let currWidth = menuBarItem.widthAnchor.constraint(equalToConstant: view.frame.size.width*0.9)
        currWidth.isActive = true
        let currHeight = menuBarItem.heightAnchor.constraint(equalToConstant: 300)
        currHeight.isActive = true

        self.navigationController?.navigationBar.addSubview(navbar)
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
class Navbar: UINavigationBar {
    let customView = UIBarButtonItem(customView: CustomNavbar())
    let navitem = UINavigationItem(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
