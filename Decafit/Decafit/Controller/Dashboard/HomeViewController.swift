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
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        hidesBottomBarWhenPushed = true
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
//        hidesBottomBarWhenPushed = false
    }
}
extension HomeViewController {
    func setupNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        let profileIcon = UIBarButtonItem(
            image: UIImage(named: "profile"),
            style: .plain, target: self, action: nil)
        profileIcon.setBackgroundImage(UIImage(named: "profile"), for: .normal, barMetrics: .default)
        profileIcon.tintColor = .clear
        let profileGreeting = UIBarButtonItem(title: "Good Morning",
                                              style: .plain, target: self, action: nil)
        profileGreeting.tintColor = DecaColor.decafitGray.color
        navigationItem.leftBarButtonItems = [profileIcon, profileGreeting]
        let notificationIcon = UIBarButtonItem(
            image: UIImage(named: "bell-icon"),
            style: .plain, target: self, action: nil)
        notificationIcon.tintColor = DecaColor.decafitPurple.color
        navigationItem.rightBarButtonItem = notificationIcon
        let backImage = UIImage(named: "back-arrow")?.withTintColor(.black)
//        backImage?.withTintColor(.black)
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationController?.navigationBar.topItem?.backBarButtonItem =
            UIBarButtonItem(image: backImage, style: .plain, target: self, action: nil)
    }
    func setupSubviews() {
        [firstLabel, todayView, focusAreaView].forEach { view.addSubview($0)}
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todayView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 40),
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
