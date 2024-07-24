//
//  OnboardingPageViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

final class OnboardingPageViewController: UIViewController {
    // MARK: - Private Properties
    var pageContainer: UIPageViewController!
    private var pages: [UIViewController] = []
    
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
            page: 0
        )
        let page2 = OnboardingViewController(
            imageName: K.Onboarding.imagePage2.rawValue,
            primatyText: K.Onboarding.primaryTextPage2.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage2.rawValue,
            page: 1
        )
        let page3 = OnboardingViewController(
            imageName: K.Onboarding.imagePage3.rawValue,
            primatyText: K.Onboarding.primaryTextPage3.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage3.rawValue,
            page: 2
        )
        
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
        
        print(index)
    }
}
