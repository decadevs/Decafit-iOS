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
//        tabBar.tintColor = .systemGreen
//        tabBar.unselectedItemTintColor = DecaColor.decafitBlack.color
//        tabBar.layer.shadowColor = DecaColor.decafitGray.color.cgColor
//        tabBar.layer.shadowOpacity = 0.2
//        tabBar.layer.shadowRadius = 5
//        tabBar.clipsToBounds = false
//        tabBar.backgroundColor = UIColor.white
        setViewControllers([windows, calenderView, home, searchView, pieView], animated: false)
        guard let items = tabBar.items else { return }
        let tabBarIcons = ["Home", "Meals", "kitchenMeals", "Messages", "Account"]
        for icon in 0 ..< items.count {
            items[icon].image = UIImage(named: tabBarIcons[icon])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}
class TabBarController: UITabBarController {
    var data = DatabaseManager.shared
    func setupTabBarForKitchenStaff() {
        tabBar.tintColor = .systemGreen
        tabBar.unselectedItemTintColor = DecaMealCustomColor.textDarkColor.color
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 5
        tabBar.clipsToBounds = false
        tabBar.backgroundColor = UIColor.white

        home.title = "Home"
        kitchenMeals.title = "Meals"
        tickets.title = "Tickets"
        messages.title = "Messages"
        account.title = "Account"

        setViewControllers([home, kitchenMeals, tickets, messages, account], animated: false)

        guard let items = tabBar.items else { return }
        let tabBarIcons = ["Home", "Meals", "kitchenMeals", "Messages", "Account"]
        for icon in 0 ..< items.count {
            items[icon].image = UIImage(named: tabBarIcons[icon])
        }
    }
}

