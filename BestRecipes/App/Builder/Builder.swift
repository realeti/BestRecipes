//
//  Builder.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func getModule(for type: InitialViewControllerType, router: Router) -> UIViewController
    func getTrendingViewController(router: RouterProtocol) -> UIViewController
}


final class Builder: BuilderProtocol {
    func getModule(for type: InitialViewControllerType, router: Router) -> UIViewController {
        switch type {
        case .home:
            getMainViewController(router: router)
        case .favorite:
            getFavoriteViewController(router: router)
        case .notification:
            getNotificationViewController(router: router)
        case .profile:
            getProfileViewController(router: router)
        }
    }
    
    private func getMainViewController(router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    
    private func getFavoriteViewController(router: RouterProtocol) -> UIViewController {
        let viewController = FavoriteViewController()
        return viewController
    }
    
    
    private func getNotificationViewController(router: RouterProtocol) -> UIViewController {
        let viewController = NotificationViewController()
        return viewController
    }
    
    
    private func getProfileViewController(router: RouterProtocol) -> UIViewController {
        let viewController = ProfileViewController()
        return viewController
    }
    
    
    func getTrendingViewController(router: RouterProtocol) -> UIViewController {
        let viewController = TrendingViewController()
        let presenter = TrendingPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}
