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
    func configureModule(for viewController: UIViewController, with router: RouterProtocol)
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
            //createProfileModule(router: router)
            createSearchModule(router: router)
        }
    }
    
    // MARK: - Create TabBar Home
    private func createHomeModule(router: RouterProtocol) -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Create TabBar Farvoite
    private func createFavoriteModule(router: RouterProtocol) -> UIViewController {
        let viewController = FavoriteViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    // MARK: - Create TabBar Notification
    private func createNotificationModule(router: RouterProtocol) -> UIViewController {
        let viewController = NotificationViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    // MARK: - Create TabBar Profile
    private func createProfileModule(router: RouterProtocol) -> UIViewController {
        let viewController = ProfileViewController()
        
        //setupViewController(viewController, title: "test", with: nil)
        return viewController
    }
    
    // MARK: - Create Trending
    func createTrendingModule(router: RouterProtocol) -> UIViewController {
        let viewController = TrendingViewController()
        let presenter = TrendingPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        setTitle(K.trendingTitle, for: viewController)
        
        return viewController
    }
    
    // MARK: - Create Search
    func createSearchModule(router: RouterProtocol) -> UIViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter(view: viewController, router: router)
        viewController.presenter = presenter
        return viewController
    }
}

// MARK: - Setup ViewController Title
extension Builder {
    private func setTitle(_ title: String, for viewController: UIViewController) {
        viewController.title = title
    }
}

// MARK: - Configure Module
extension Builder {
    func configureModule(for viewController: UIViewController, with router: RouterProtocol) {
        setTitleAttributes(for: viewController)
        setCustomBackButton(for: viewController, with: router)
    }
}

// MARK: - Custom Title Attributes
extension Builder {
    private func setTitleAttributes(for viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else {
            return
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.getFont(.poppinsSemiBold, size: 24.0),
            .foregroundColor: UIColor(resource: .blackBase)
        ]
        
        navigationController.navigationBar.titleTextAttributes = attributes
    }
}

// MARK: - Custom Navigation BackButton
extension Builder {
    private func setCustomBackButton(for viewController: UIViewController, with router: RouterProtocol) {
        let customView = UIButton(type: .system)
        customView.setBackgroundImage(.arrowLeft, for: .normal)
        
        let action = UIAction { _ in
            router.popToPrevious()
        }
        
        customView.addAction(action, for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
    }
}
