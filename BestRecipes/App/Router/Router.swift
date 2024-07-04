//
//  Router.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

//MARK: - Router Protocol

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    
    //func initialViewController()
    func showTrending()
    func popToRoot()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    
    //MARK: - Initial
    
    /*func initialViewController() {
        if let navigationController {
            guard let mainViewController = builder?.getMainViewController(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }*/
    
    // MARK: Start
    
    func start(with viewControllerType: InitialViewControllerType) {
        switch viewControllerType {
        case .home:
            showHome()
        case .favorite:
            showFavorite()
        case .notification:
            showNotification()
        case .profile:
            showProfile()
        }
    }
    
    //MARK: - Home
    
    private func showHome() {
        if let navigationController {
            guard let homeViewController = builder?.getMainViewController(router: self) else { return }
            navigationController.viewControllers = [homeViewController]
        }
    }
    
    //MARK: - Favorite
    
    private func showFavorite() {
        if let navigationController {
            guard let favoriteViewController = builder?.getFavoriteViewController(router: self) else { return } //getFavoriteViewController
            navigationController.viewControllers = [favoriteViewController]
        }
    }
    
    //MARK: - Notification
    
    private func showNotification() {
        if let navigationController {
            guard let notificationViewController = builder?.getNotificationViewController(router: self) else { return } //getFavoriteViewController
            navigationController.viewControllers = [notificationViewController]
        }
    }
    
    //MARK: - Profile
    
    private func showProfile() {
        if let navigationController {
            guard let profileViewController = builder?.getProfileViewController(router: self) else { return } //getFavoriteViewController
            navigationController.viewControllers = [profileViewController]
        }
    }
    
    
    //MARK: - Trending
    
    func showTrending() {
        if let navigationController {
            guard let trendingViewController = builder?.getTrendingViewController(router: self) else { return }
            navigationController.pushViewController(trendingViewController, animated: true)
        }
    }
    
    
    //MARK: - Detail
    
    func showDetail() {
        /*if let navigationController {
            guard let detailViewController = builder?.getDetailViewController(router: self) else { return }
            navigationController?.pushViewController(detailViewController, animated: true)
        }*/
    }
    
    
    //MARK: - PopToRoot
    
    func popToRoot() {
        if let navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
