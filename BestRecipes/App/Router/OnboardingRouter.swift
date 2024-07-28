//
//  OnboardingRouter.swift
//  BestRecipes
//
//  Created by realeti on 27.07.2024.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    var builder: BuilderProtocol { get set }
    
    func showSpecificPage(at page: Int, with viewControllers: [UIViewController])
    func showNextPage(with viewControllers: [UIViewController])
    func showStartVC()
}

final class OnboardingRouter: OnboardingRouterProtocol {
    // MARK: - Public Properties
    var builder: BuilderProtocol
    var pageContainer: UIPageViewController
    
    // MARK: - Private Properties
    private var currentPage = 0
    
    // MARK: - Init
    init(builder: BuilderProtocol, pageContainer: UIPageViewController) {
        self.builder = builder
        self.pageContainer = pageContainer
    }
    
    // MARK: Start
    func start() {
        let onboardingPageVC = builder.createOnboardingPageModule()
        onboardingPageVC.modalPresentationStyle = .fullScreen
        
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        if let rootViewController = window?.rootViewController {
            rootViewController.present(onboardingPageVC, animated: true)
        }
    }
    
    // MARK: - Show Specific Onboarding Page
    func showSpecificPage(at page: Int, with viewControllers: [UIViewController]) {
        guard page >= 0, page < viewControllers.count else {
            return
        }
        
        let direction: UIPageViewController.NavigationDirection = page > currentPage ? .forward : .reverse
        let nextVC = viewControllers[page]
        
        pageContainer.setViewControllers([nextVC], direction: direction, animated: true, completion: { [weak self] completed in
            if completed {
                self?.currentPage = page
            }
        })
    }
    
    // MARK: - Show Next Page
    func showNextPage(with viewControllers: [UIViewController]) {
        guard currentPage < viewControllers.count - 1 else {
            showStartVC()
            return
        }
        
        let nextPage = currentPage + 1
        let nextVC = viewControllers[nextPage]
        pageContainer.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] completed in
            if completed {
                self?.currentPage = nextPage
            }
        }
    }
    
    func showStartVC() {
        /// save onboarding status
        DataManager.shared.markOnboardingAsCompleted() // transfer in onboarding page presenter
        
        /// show main screen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .fade
            transition.subtype = .fromRight
            window.layer.add(transition, forKey: kCATransition)
            window.rootViewController = CustomTabBarController()
            
            window.overrideUserInterfaceStyle = .light
            window.makeKeyAndVisible()
        }
    }
}
