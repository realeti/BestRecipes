//
//  OnboardingPageViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

protocol OnboardingPageProtocol: AnyObject {
    func showSpecificPage(_ page: Int)
    func showNextPage()
    func showStartVC()
}

final class OnboardingPageViewController: UIViewController {
    // MARK: - Private Properties
    private var pageContainer: UIPageViewController!
    private var pages: [UIViewController] = []
    private var currentPage = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        setDelegates()
        setupViewControllers()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        pageContainer.dataSource = self
        pageContainer.delegate = self
    }
    
    // MARK: - Setup PageViewController
    private func setupPageViewController() {
        pageContainer = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        addChild(pageContainer)
        view.addSubview(pageContainer.view)
        pageContainer.view.frame = view.bounds
        pageContainer.didMove(toParent: self)
    }
}

// MARK: - Setup Page Controllers
private extension OnboardingPageViewController {
    func setupViewControllers() {
        let page1 = OnboardingViewController(
            imageName: K.Onboarding.imagePage1.rawValue,
            primatyText: K.Onboarding.primaryTextPage1.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage1.rawValue,
            buttonTitle: K.Onboarding.continueButtonTitle.rawValue,
            page: 0
        )
        
        let page2 = OnboardingViewController(
            imageName: K.Onboarding.imagePage2.rawValue,
            primatyText: K.Onboarding.primaryTextPage2.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage2.rawValue,
            buttonTitle: K.Onboarding.continueButtonTitle.rawValue,
            page: 1
        )
        
        let page3 = OnboardingViewController(
            imageName: K.Onboarding.imagePage3.rawValue,
            primatyText: K.Onboarding.primaryTextPage3.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage3.rawValue,
            buttonTitle: K.Onboarding.startCooking.rawValue,
            page: 2
        )
        
        page1.delegate = self
        page2.delegate = self
        page3.delegate = self
        
        pages = [page1, page2, page3]
        
        /// set start view controller
        if let firstPage = pages.first {
            pageContainer.setViewControllers([firstPage], direction: .forward, animated: true)
        }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentViewController = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentViewController) else {
            return
        }
        currentPage = index
    }
}

// MARK: - OnboardingPage Delegate methods
extension OnboardingPageViewController: OnboardingPageProtocol {
    func showSpecificPage(_ page: Int) {
        guard page >= 0, page < pages.count else {
            return
        }
        
        let direction: UIPageViewController.NavigationDirection = page > currentPage ? .forward : .reverse
        let nextVC = pages[page]
        
        pageContainer.setViewControllers([nextVC], direction: direction, animated: true) { [weak self] completed in
            if completed {
                self?.currentPage = page
            }
        }
    }
    
    func showNextPage() {
        guard currentPage < pages.count - 1 else {
            showStartVC()
            return
        }
        
        let nextPage = currentPage + 1
        let nextVC = pages[nextPage]
        pageContainer.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] completed in
            if completed {
                self?.currentPage = nextPage
            }
        }
    }
    
    func showStartVC() {
        /// save onboarding status
        DataManager.shared.markOnboardingAsCompleted()
        
        /// show main screen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .fade
            transition.subtype = .fromRight
            window.layer.add(transition, forKey: kCATransition)
            window.rootViewController = CustomTabBarController()
            
            /*UIView.transition(
                with: window,
                duration: 0.3,
                options: [.transitionFlipFromLeft],
                animations: {
                    window.rootViewController = CustomTabBarController()
                }, completion: nil
            )*/
            
            window.overrideUserInterfaceStyle = .light
            window.makeKeyAndVisible()
        }
    }
}
