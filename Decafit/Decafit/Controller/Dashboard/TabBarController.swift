//
//  TabBarController.swift
//  Decafit
//
//  Created by Decagon on 27/07/2022.
//

import UIKit

class TabBarController: UITabBarController {
    let home = HomeViewController()
    let windows = WindowsViewController()
    let calenderView = CalenderViewController()
    let searchView = SearchViewController()
    let pieView = LogsViewController()
    func setupTabBar() {
        tabBar.tintColor = DecaColor.decafitPurple.color
        tabBar.unselectedItemTintColor = DecaColor.decafitGray.color
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .white
        setViewControllers([windows, calenderView, home, searchView, pieView], animated: false)
        guard let items = tabBar.items else { return }
        let tabBarIcons = ["window", "calender", "plus", "search", "pie"]
        for icon in 0 ..< items.count {
            items[icon].image = UIImage(named: tabBarIcons[icon])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        selectedIndex = 2
    }
}
