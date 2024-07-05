//
//  Builder.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createModule(for initialModuleType: InitialModuleType, router: Router) -> UIViewController
    func createTrendingModule(router: RouterProtocol) -> UIViewController
    
    func configureTabModule(for initialModuleType: InitialModuleType, with config: ModuleConfiguration)
}


final class Builder: BuilderProtocol {
    func createModule(for initialModuleType: InitialModuleType, router: Router) -> UIViewController {
        switch initialModuleType {
        case .home:
            createHomeModule(router: router)
        case .favorite:
            createFavoriteModule(router: router)
        case .notification:
            createNotificationModule(router: router)
        case .profile:
            createProfileModule(router: router)
        }
    }
    
    private func createHomeModule(router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    
    private func createFavoriteModule(router: RouterProtocol) -> UIViewController {
        let viewController = FavoriteViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    
    private func createNotificationModule(router: RouterProtocol) -> UIViewController {
        let viewController = NotificationViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    
    private func createProfileModule(router: RouterProtocol) -> UIViewController {
        let viewController = ProfileViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    
    func createTrendingModule(router: RouterProtocol) -> UIViewController {
        let viewController = TrendingViewController()
        let presenter = TrendingPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
}

// MARK: - Configure Tab Controllers
extension Builder {
    func configureTabModule(for initialModuleType: InitialModuleType, with config: ModuleConfiguration) {
        let title: String
        
        switch initialModuleType {
        case .home:
            title = K.homeTitle
        case .favorite:
            title = K.favoriteTitle
        case .notification:
            title = K.notificationTitle
        case .profile:
            title = K.profileTitle
        }
        
        configureViewController(with: config, and: title)
    }
}

// MARK: - Configure View Controller
extension Builder {
    private func configureViewController(with config: ModuleConfiguration, and title: String) {
        setCustomTitle(for: config.navigationController, title: title)
    }
    
    private func setCustomTitle(for navigationController: UINavigationController, title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.getFont(.poppinsSemiBold, size: 24.0),
            .foregroundColor: UIColor(resource: .blackBase)
        ]
        
        navigationController.navigationBar.topItem?.setValue(true, forKey: "__largeTitleTwoLineMode") // hack xd
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.title = title
        navigationController.navigationBar.titleTextAttributes = attributes
    }
}
