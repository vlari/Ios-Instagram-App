//
//  TabBarViewController.swift
//  Instagram
//
//  Created by Obed Garcia on 28/10/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }

        let currentUser = User(username: username, email: email)
        
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let activity = NotificationsViewController()
        let profile = ProfileViewController(user: currentUser)
        
        let homeNav = UINavigationController(rootViewController: home)
        let exploreNav = UINavigationController(rootViewController: explore)
        let cameraNav = UINavigationController(rootViewController: camera)
        let activityNav = UINavigationController(rootViewController: activity)
        let profileNav = UINavigationController(rootViewController: profile)
        
        homeNav.navigationBar.tintColor = .label
        exploreNav.navigationBar.tintColor = .label
        cameraNav.navigationBar.tintColor = .label
        activityNav.navigationBar.tintColor = .label
        profileNav.navigationBar.tintColor = .label
        
        self.setViewControllers([homeNav, exploreNav, cameraNav, activityNav, profileNav], animated: false)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        exploreNav.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari"), tag: 1)
        cameraNav.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), tag: 1)
        activityNav.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 1)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)
        
        self.setViewControllers(
            [homeNav, exploreNav, cameraNav, activityNav, profileNav],
            animated: false
        )
    }
}
