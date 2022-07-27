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
//        tabBar.layer.shadowColor = DecaColor.decafitGray.color.cgColor
//        tabBar.layer.shadowOpacity = 0.2
//        tabBar.layer.shadowRadius = 5
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = .white
        home.title = "Home"
        windows.title = "Profile"
        calenderView.title = "Check Workout Date"
        searchView.title = "Search"
        pieView.title = "Past Workouts"
        setViewControllers([windows, calenderView, home, searchView, pieView], animated: false)
        guard let items = tabBar.items else { return }
        let tabBarIcons = ["calendar", "plus", "", ""]
        //Change to image names
        for icon in 0 ..< items.count {
            items[icon].image = UIImage(named: tabBarIcons[icon])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}
