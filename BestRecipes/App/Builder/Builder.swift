//
//  Builder.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho & realeti on 02.07.2024.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func configureNavigationController(_ navigationController: UINavigationController)
    func createModule(for initialModuleType: InitialModuleType, router: Router) -> UIViewController
    func createTrendingModule(title: String, recipes: [Recipe], router: RouterProtocol) -> UIViewController
    func createSearchModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(recipe: RecipeDetailModel, router: RouterProtocol) -> UIViewController
    func createCreateRecipeModule(router: RouterProtocol) -> UIViewController
}


final class Builder: BuilderProtocol {
    // MARK: - Create TabBar Modules
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
    
    // MARK: - Create TabBar Home
    private func createHomeModule(router: RouterProtocol) -> UIViewController {
        let presenter = MainPresenter(router: router)
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    // MARK: - Create TabBar Farvoite
    private func createFavoriteModule(router: RouterProtocol) -> UIViewController {
        let viewController = FavoriteViewController()
        let presenter = FavoritePresenter(view: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
    
    // MARK: - Create TabBar Notification
    private func createNotificationModule(router: RouterProtocol) -> UIViewController {
        let viewController = NotificationViewController()
        return viewController
    }
    
    // MARK: - Create TabBar Profile
    private func createProfileModule(router: RouterProtocol) -> UIViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController, router: router)
        viewController.presenter = presenter
        viewController.title = K.profileTitle
        return viewController
    }
    
    // MARK: - Create Trending
    func createTrendingModule(title: String, recipes: [Recipe], router: RouterProtocol) -> UIViewController {
        let viewController = TrendingViewController()
        let presenter = TrendingPresenter(view: viewController, router: router, recipes: recipes)
        viewController.presenter = presenter
        viewController.title = title
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    // MARK: - Create Search
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    // MARK: - Create Detail
    func createDetailModule(recipe: RecipeDetailModel, router: RouterProtocol) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController, router: router, model: recipe)
        viewController.presenter = presenter
        viewController.hidesBottomBarWhenPushed = true
        viewController.title = K.detailTitle
        return viewController
    }
  
    // MARK: - Create Recipe
    func createCreateRecipeModule(router: RouterProtocol) -> UIViewController {
        let viewController = CreateRecipeViewController()
        let presenter = CreateRecipePresenter(vc: viewController, router: router)
        viewController.presenter = presenter
        viewController.hidesBottomBarWhenPushed = true
        viewController.title = K.createRecipeTitle
        return viewController
    }
}

// MARK: - Configure Navigation Controller
extension Builder {
    func configureNavigationController(_ navigationController: UINavigationController) {
        /// get standart navigationController appearance
        let appearance = navigationController.navigationBar.standardAppearance
        
        /// get back button image
        let backImage = UIImage(resource: .arrowLeft)
        
        /// attributes for navigation title
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.getFont(.poppinsSemiBold, size: 24.0),
            .foregroundColor: UIColor(resource: .blackBase)
        ]
        
        /// clear back button title color
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        /// set back button image
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        /// set navigation title attributes
        appearance.titleTextAttributes = attributes
        
        /// set back button tint color
        navigationController.navigationBar.tintColor = .blackBase
    }
}
