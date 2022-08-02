//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

final class HomeViewController: UIViewController, FocusAreaViewDelegate {
    
    static var shared: HomeViewController?
    static func getHomeView() -> HomeViewController {
        return shared ?? HomeViewController()
    }
    lazy var todayView: TodaySessionView = {
        let view = TodaySessionView()
        return view
    }()
    lazy var focusAreaView: FocusAreaView = {
        let view = FocusAreaView()
        view.delegate = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
    }
    func didDisplayInputScreen(_ screen: InputViewController, image: UIImage?, title: String) {
        screen.titleLabel.text = title
//        screen.topImageView.collectionView(todayView)
        self.navigationController?.pushViewController(screen, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        setupNavigation()
    }
}
extension HomeViewController {
    func setupNavigation() {
        let navbarFrame = CGRect(x: 5, y: 0, width: view.bounds.width, height: 100)
        let navbar: UIBarButtonItem = UIBarButtonItem(customView: CustomNavbar(frame: navbarFrame))
        navigationItem.leftBarButtonItems = [navbar]
        self.navigationController?.navigationBar.isTranslucent = false
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
