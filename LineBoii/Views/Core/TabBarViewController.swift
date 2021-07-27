//
//  TabBarViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let vc2 = OrderViewController()
        let vc3 = InboxViewController()
        let vc4 = OthersViewController()
        
        vc1.title = "Home"
        vc2.title = "Order"
        vc3.title = "Inbox"
        vc4.title = "Others"
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        vc2.navigationItem.largeTitleDisplayMode = .never
        vc3.navigationItem.largeTitleDisplayMode = .never
        vc4.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "clock.arrow.circlepath"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Inbox", image: UIImage(systemName: "tray"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Others", image: UIImage(systemName: "ellipsis"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)

    }
    

}
