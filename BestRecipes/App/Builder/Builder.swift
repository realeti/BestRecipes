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
}


final class Builder: BuilderProtocol {
    func getMainViewController(router: RouterProtocol) -> UIViewController {
        let network = NetworkManager()
        let presenter = MainPresenter(network: network, router: router)
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    
    func getTrendingViewController(router: RouterProtocol) -> UIViewController {
        let viewController = TrendingViewController()
        let presenter = TrendingPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}
