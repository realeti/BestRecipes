//
//  Builder.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func getMainViewController(router: RouterProtocol) -> UIViewController
    func getTrendingViewController(router: RouterProtocol) -> UIViewController
    func getFavoriteViewController(router: RouterProtocol) -> UIViewController
    func getNotificationViewController(router: RouterProtocol) -> UIViewController
    func getProfileViewController(router: RouterProtocol) -> UIViewController
}


final class Builder: BuilderProtocol {
    func getMainViewController(router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    
    func getFavoriteViewController(router: RouterProtocol) -> UIViewController {
        let viewController = FavoriteViewController()
        return viewController
    }
    
    
    func getNotificationViewController(router: RouterProtocol) -> UIViewController {
        let viewController = NotificationViewController()
        return viewController
    }
    
    
    func getProfileViewController(router: RouterProtocol) -> UIViewController {
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
