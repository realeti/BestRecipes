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
        let homeConfig = tabBarItemConfiguration(
            image: .homeInactive,
            selectedImage: .homeActive,
            tag: 0,
            builder: Builder(),
            initialViewControllerType: .home
        )
        
        let favoritesConfig = tabBarItemConfiguration(
            image: .favoritesInactive,
            selectedImage: .favoritesActive,
            tag: 1,
            builder: Builder(),
            initialViewControllerType: .favorite
        )
        
        let notificationConfig = tabBarItemConfiguration(
            image: .notificationInactive,
            selectedImage: .notificationActive,
            tag: 2,
            builder: Builder(),
            initialViewControllerType: .notification
        )
        
        let profileConfig = tabBarItemConfiguration(
            image: .profileInactive,
            selectedImage: .profileActive,
            tag: 3,
            builder: Builder(),
            initialViewControllerType: .profile
        )
        
        let viewControllers = [
            createTabBarItem(with: homeConfig),
            createTabBarItem(with: favoritesConfig),
            createTabBarItem(with: notificationConfig),
            createTabBarItem(with: profileConfig)
        ]
        
        self.viewControllers = viewControllers
    }
}

// MARK: - Create TabBar Item
extension CustomTabBarController {
    private func createTabBarItem(with config: tabBarItemConfiguration) -> UINavigationController {
        let item = UINavigationController()
        let router = Router(navigationController: item, builder: config.builder)
        router.start(with: config.initialViewControllerType)
        
        item.tabBarItem.image = config.image
        item.tabBarItem.selectedImage = config.selectedImage
        item.tabBarItem.tag = config.tag
        return item
    }
}

// MARK: - View Controller Type
enum InitialViewControllerType {
    case home, favorite, notification, profile
}

// MARK: - TabBar Item configuration
fileprivate struct tabBarItemConfiguration {
    let image: UIImage
    let selectedImage: UIImage
    let tag: Int
    let builder: BuilderProtocol
    let initialViewControllerType: InitialViewControllerType
}
