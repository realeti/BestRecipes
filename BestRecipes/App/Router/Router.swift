//
//  Router.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho & realeti on 02.07.2024.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var builder: BuilderProtocol { get set }
    
    func start(with initialModuleType: InitialModuleType)
    func showTrending(title: String, recipes: [Recipe])
    func showDetail(recipe: RecipeDetailModel)
    func showSearch()
    func popToRoot()
    func popToPrevious()
}

final class Router: RouterProtocol {
    // MARK: - Public Properties
    var navigationController: UINavigationController
    var builder: BuilderProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
        builder.configureNavigationController(navigationController)
    }
    
    // MARK: Start
    func start(with initialModuleType: InitialModuleType) {
        let viewController = builder.createModule(for: initialModuleType, router: self)
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Trending
    func showTrending(title: String, recipes: [Recipe]) {
        let trendingViewController = builder.createTrendingModule(
            title: title,
            recipes: recipes,
            router: self
        )
        navigationController.pushViewController(trendingViewController, animated: true)
    }
    
    // MARK: - Detail
    func showDetail(recipe: RecipeDetailModel) {
        let detailViewController = builder.createDetailModule(recipe: recipe, router: self)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Search
    func showSearch() {
        let searchViewController = builder.createSearchModule(router: self)
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    // MARK: - CreateRecipe
    func showCreateRecipe() {
        let createRecipeViewController = builder.createCreateRecipeModule(router: self)
        navigationController.pushViewController(createRecipeViewController, animated: true)
    }
    
    // MARK: - PopToRoot
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    // MARK: - PopToPrevious
    func popToPrevious() {
        navigationController.popViewController(animated: true)
    }
}
