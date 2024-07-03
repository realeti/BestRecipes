//
//  CustomTabBarController.swift
//  BestRecipes
//
//  Created by realeti on 01.07.2024.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
}

// MARK: - Setup Tabs
extension CustomTabBarController {
    private func setupTabs() {
        let homeVC = MainViewController()
        let favoritesVC = FavoriteVC()
        let notificationVC = NotificationVC()
        let profileVC = ProfileVC()
        
        let home = createTabBarItem(
            image: .homeInactive,
            selectedImage: .homeActive,
            tag: 0,
            vc: homeVC
        )
        
        let favorites = createTabBarItem(
            image: .favoritesInactive,
            selectedImage: .favoritesActive,
            tag: 1,
            vc: favoritesVC
        )
        
        let notification = createTabBarItem(
            image: .notificationInactive,
            selectedImage: .notificationActive,
            tag: 2,
            vc: notificationVC
        )
        
        let profile = createTabBarItem(
            image: .profileInactive,
            selectedImage: .profileActive,
            tag: 3,
            vc: profileVC
        )
        
        viewControllers = [home, favorites, notification, profile]
    }
}

// MARK: - Create TabBar Item
extension CustomTabBarController {
    private func createTabBarItem(image: UIImage, selectedImage: UIImage, tag: Int, vc: UIViewController) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        vc.tabBarItem.tag = tag
        return vc
    }
}

// MARK: - Mock Controllers
class MainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
    }
}

class FavoriteVC: UIViewController {}
class NotificationVC: UIViewController {}
class ProfileVC: UIViewController {}
