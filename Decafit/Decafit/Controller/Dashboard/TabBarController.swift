//
//  TabBarController.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit

class TabBarController: UITabBarController {
    let home = UINavigationController(rootViewController: HomeViewController())
    let windows = WindowsViewController()
    let calenderView = CalenderViewController()
    let searchView = SearchViewController()
    let pieView = LogsViewController()
    func setupTabBar() {
        tabBar.tintColor = DecaColor.decafitPurple.color
        tabBar.unselectedItemTintColor = DecaColor.decafitGray.color
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .white
        setViewControllers([windows, calenderView, home, searchView, pieView], animated: false)
        guard let items = tabBar.items else { return }
        let tabBarIcons = ["window", "calender", "plus", "search", "pie"]
        for icon in 0 ..< items.count {
            items[icon].image = UIImage(named: tabBarIcons[icon])
            items[icon].title = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        selectedIndex = 2
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 110
        tabBar.frame.origin.y = view.frame.height - 110
    }
}
