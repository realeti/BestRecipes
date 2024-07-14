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
    
    func start(with initialModuleType: InitialModuleType)
    func showTrending(_ recipes: [Recipe])
    func showDetail(recipe: RecipeDetailModel)
    func showSearch()
    func popToRoot()
    func popToPrevious()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController
    var builder: BuilderProtocol
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    // MARK: Start
    
    func start(with initialModuleType: InitialModuleType) {
        let router = self
        let viewController = builder.createModule(for: initialModuleType, router: router)
        navigationController.viewControllers = [viewController]
    }
    
    //MARK: - Trending
    
    func showTrending(_ recipes: [Recipe]) {
        let router = self
        let trendingViewController = builder.createTrendingModule(router: router, recipes: recipes)
        navigationController.pushViewController(trendingViewController, animated: true)
        builder.configureModule(for: trendingViewController, with: router)
    }
    
    //MARK: - Detail
    
    func showDetail(recipe: RecipeDetailModel) {
        let router = self
        let detailViewController = builder.createDetailModule(router: router, recipe: recipe)
        navigationController.pushViewController(detailViewController, animated: true)
        builder.configureModule(for: detailViewController, with: router)
    }
    
    //MARK: - Search
    func showSearch() {
        let router = self
        let searchViewController = builder.createSearchModule(router: router)
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    //MARK: - PopToRoot
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    //MARK: - PopToPrevious
    
    func popToPrevious() {
        navigationController.popViewController(animated: true)
    }
}
