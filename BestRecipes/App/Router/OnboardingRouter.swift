//
//  OnboardingRouter.swift
//  BestRecipes
//
//  Created by realeti on 27.07.2024.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    init(builder: BuilderProtocol, pageContainer: UIPageViewController)
    
    func updateCurrentPage(to page: Int)
    func showSpecificPage(at page: Int)
    func showNextPage()
    func showStartVC()
}

final class OnboardingRouter: OnboardingRouterProtocol {
    // MARK: - Private Properties
    private var builder: BuilderProtocol
    private var pageContainer: UIPageViewController
    private var pageProvider: OnboardingPageProvider?
    private var currentPage = 0
    private var isAnimatingTransition = false
    
    // MARK: - Init
    init(builder: BuilderProtocol, pageContainer: UIPageViewController) {
        self.builder = builder
        self.pageContainer = pageContainer
    }
    
    // MARK: Start
    func start() {
        let onboardingPageVC = builder.createOnboardingPageModule(pageContainer: pageContainer, router: self)
        onboardingPageVC.modalPresentationStyle = .fullScreen
        
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        if let rootViewController = window?.rootViewController,
           let pageProvider = onboardingPageVC as? OnboardingPageProvider {
            rootViewController.present(onboardingPageVC, animated: true)
            self.pageProvider = pageProvider
        }
    }
    
    // MARK: - Update Current Page
    func updateCurrentPage(to page: Int) {
        currentPage = page
    }
    
    // MARK: - Show Specific Onboarding Page
    func showSpecificPage(at page: Int) {
        guard !isAnimatingTransition, let pages = pageProvider?.pages, page >= 0, page < pages.count else {
            return
        }
        
        isAnimatingTransition = true
        
        let direction: UIPageViewController.NavigationDirection = page > currentPage ? .forward : .reverse
        let nextVC = pages[page]
        
        pageContainer.setViewControllers([nextVC], direction: direction, animated: true, completion: { [weak self] completed in
            self?.isAnimatingTransition = false
            
            if completed {
                self?.currentPage = page
            }
        })
    }
    
    // MARK: - Show Next Page
    func showNextPage() {
        guard !isAnimatingTransition, let pages = pageProvider?.pages, currentPage < pages.count - 1 else {
            showStartVC()
            return
        }
        
        isAnimatingTransition = true
        
        let nextPage = currentPage + 1
        let nextVC = pages[nextPage]
        pageContainer.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] completed in
            self?.isAnimatingTransition = false
            
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
