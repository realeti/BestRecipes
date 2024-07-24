//
//  OnboardingPageViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
    // MARK: - Private Properties
    private var pages: [UIViewController] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupViewControllers()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}

// MARK: - Setup Page Controllers
private extension OnboardingPageViewController {
    func setupViewControllers() {
        let page1 = OnboardingViewController(
            imageName: K.Onboarding.imagePage1.rawValue,
            primatyText: K.Onboarding.primaryTextPage1.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage1.rawValue
        )
        let page2 = OnboardingViewController(
            imageName: K.Onboarding.imagePage2.rawValue,
            primatyText: K.Onboarding.primaryTextPage2.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage2.rawValue
        )
        let page3 = OnboardingViewController(
            imageName: K.Onboarding.imagePage3.rawValue,
            primatyText: K.Onboarding.primaryTextPage3.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage3.rawValue
        )
        
        pages = [page1, page2, page3]
        
        /// set start view controller
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
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
    
    /// count of pages
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    //
}
