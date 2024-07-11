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
            initialModuleType: .home
        )
        
        let favoritesConfig = tabBarItemConfiguration(
            image: .favoritesInactive,
            selectedImage: .favoritesActive,
            tag: 1,
            builder: Builder(),
            initialModuleType: .favorite
        )
        
        let notificationConfig = tabBarItemConfiguration(
            image: .notificationInactive,
            selectedImage: .notificationActive,
            tag: 2,
            builder: Builder(),
            initialModuleType: .notification
        )
        
        let profileConfig = tabBarItemConfiguration(
            image: .profileInactive,
            selectedImage: .profileActive,
            tag: 3,
            builder: Builder(),
            initialModuleType: .profile
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
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, builder: config.builder)
        router.start(with: config.initialModuleType)

        navigationController.tabBarItem.image = config.image
        navigationController.tabBarItem.selectedImage = config.selectedImage
        navigationController.tabBarItem.tag = config.tag

        return navigationController
    }
}

// MARK: - View Controller Type
enum InitialModuleType {
    case home, favorite, notification, profile
}

// MARK: - TabBar Item Configuration
fileprivate struct tabBarItemConfiguration {
    let image: UIImage
    let selectedImage: UIImage
    let tag: Int
    let builder: BuilderProtocol
    let initialModuleType: InitialModuleType
}
