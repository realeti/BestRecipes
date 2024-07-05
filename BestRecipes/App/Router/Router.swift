//
//  Router.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

//MARK: - Router Protocol

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var builder: BuilderProtocol { get set }
    
    //func initialViewController()
    func start(with viewControllerType: InitialViewControllerType)
    func showTrending()
    func popToRoot()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController
    var builder: BuilderProtocol
    
    
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
        let viewController = builder.getModule(for: viewControllerType, router: self)
        navigationController.viewControllers = [viewController]
    }
    
    
    //MARK: - Trending
    
    func showTrending() {
        let trendingViewController = builder.getTrendingViewController(router: self)
            navigationController.pushViewController(trendingViewController, animated: true)
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
        navigationController.popToRootViewController(animated: true)
    }
}
