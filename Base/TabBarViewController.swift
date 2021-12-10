//
//  TabBarViewController.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    let profileView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "blue something")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
        tabBarSetup()
    }
    
    func tabBarSetup() {
        viewControllers = [
        createTabBatItem(for: ArticleListViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "HomeIcon")!),
        createTabBatItem(for: ArticleListViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "DoctorIcon")!),
        createTabBatItem(for: ArticleListViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(named: "HistoryIcon")!)
        ]
    }
    
    fileprivate func createTabBatItem(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return nav
    }
}
