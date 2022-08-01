//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit

final class HomeViewController: UIViewController, TodaySessionViewDelegate {
    static var shared: HomeViewController?
    static func getHomeView() -> HomeViewController {
        return shared ?? HomeViewController()
    }
    lazy var firstLabel: UILabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 24, font: .poppinsMedium).bold(),
                            textColor: DecaColor.decafitBlack.color, numberOfLines: 1,
                            text: "Your daily tracker", kerning: 1.2))
        return label
    }()
    lazy var todayView: TodaySessionView = {
        let view = TodaySessionView()
        view.delegate = self
        return view
    }()
    lazy var focusAreaView = FocusAreaView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupSubviews()
    }
    func didDisplayInputScreen(_ screen: InputViewController) {
        self.navigationController?.pushViewController(screen, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
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
        [firstLabel, todayView, focusAreaView].forEach { view.addSubview($0)}
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todayView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 15),
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
