//
//  ViewController.swift
//  Decafit
//
//  Created by Decagon on 11/07/2022.
//

import UIKit
import SQLite
import Apollo
import SideMenu
import KeychainSwift
import RealmSwift

final class HomeViewController: UIViewController {
    static var shared: HomeViewController?
    static func getHomeView() -> HomeViewController {
        return shared ?? HomeViewController()
    }
    
    let keychain = KeychainSwift()
    let data = DataManager.shared
    let defaults = UserDefaults.standard
    var dialogCompletion: (() -> Void)?

    let realmDb = StorageManager.shared
    let realm = try! Realm()
    var logViewModel = LogViewModel()

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

        data.fetchWorkouts()
        data.fetchReportFromServer(userId: view.getUserID())
        // fetch reports from server, extract them and populate the realm
        data.fetchReportFromServerCompletion = { result in
            print("Report Fetched from Server", result)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: true)
        focusAreaView.collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }

    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            print("Connected")
        } else {
            print("Not connected")
        }
    }
    
    @objc func showProfile(_ sender: DecaButton) {
        let menu = SideMenuNavigationController(rootViewController: ProfileViewController())
        menu.alwaysAnimate = true
        menu.leftSide = true
        menu.menuWidth = 300
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
    }
    @objc func showCalenderView(_ sender: DecaButton) {
        let menu = SideMenuNavigationController(rootViewController: CalenderViewController())
        menu.alwaysAnimate = true
        menu.menuWidth = view.bounds.width*0.95
        menu.presentationStyle = .menuSlideIn
        menu.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(hamburgerTapped))
        present(menu, animated: true, completion: nil)
    }
    @objc func hamburgerTapped() {
        
    }
    var mainTitleLabel: DecaLabel = {
        let label = DecaLabel()
        label.configure(with: DecaLabelViewModel(
                            font: decaFont(size: 22, font: .ubuntuBold), textColor: DecaColor.black.color, numberOfLines: 1,
                            text: "Your Daily Tracker", kerning: 0))
         return label
    }()
    
}

extension HomeViewController: FocusAreaViewDelegate {

    func showDialog(workoutId: String) {
        Alert.showDialog(self, title: "Continue Workout?",
                         message: Constants.FocusAreaDialogMsg,
                         firstAction: "Restart",
                         secondAction: "Resume")
    }
    
    func didDisplayFitConfigScreen(_ screen: FitConfigViewController, image: UIImage?, title: String, workoutId: String) {
        screen.topImageView.firstLabel.text = title
        screen.topImageView.fitConfigImage.image = image
        screen.selectedWorkoutid = workoutId
        self.navigationController?.pushViewController(screen, animated: true)
    }

    func setupNavigation() {
        let navbar = UINavigationBar(frame: CGRect(x: 10, y: 20, width: 340, height: 70))
        navbar.backgroundColor = .white
        let menuBarItem = CustomNavView()
        
        menuBarItem.navProfileImageBtn.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        menuBarItem.navbarRightCalender.addTarget(self, action: #selector(showCalenderView), for: .touchUpInside)
        navbar.addSubview(menuBarItem)
        
        menuBarItem.topAnchor.constraint(equalTo: navbar.topAnchor, constant: -10).isActive = true
        let currWidth = menuBarItem.widthAnchor.constraint(equalToConstant: view.frame.size.width*0.95)
        currWidth.isActive = true
        let currHeight = menuBarItem.heightAnchor.constraint(equalToConstant: 50)
        currHeight.isActive = true
        
        navigationController?.navigationBar.addSubview(navbar)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .green
        navigationController?.navigationBar.shouldRemoveShadow(true)
        navigationController?.navigationBar.barStyle = .default
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    func setupSubviews() {
        [mainTitleLabel, todayView, focusAreaView].forEach { view.addSubview($0)}
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todayView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 25),
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
