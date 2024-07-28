//
//  OnboardingPageViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

protocol OnboardingPageProvider: AnyObject {
    var pages: [UIViewController] { get }
}

final class OnboardingPageViewController: UIViewController, OnboardingPageProvider {
    // MARK: - Public Properties
    var presenter: OnboardingPagePresenterProtocol!
    var pages: [UIViewController] = []
    
    // MARK: - Private Properties
    private var pageContainer: UIPageViewController
    private var currentPage = 0 {
        didSet {
            presenter.updateCurrentPage(to: currentPage)
        }
    }
    
    // MARK: - Init
    init(pageContainer: UIPageViewController) {
        self.pageContainer = pageContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}

// MARK: - Add PageViewController
extension OnboardingPageViewController {
    func setupPageViewController() {
        addChild(pageContainer)
        view.addSubview(pageContainer.view)
        pageContainer.view.frame = view.bounds
        pageContainer.didMove(toParent: self)
    }
}

// MARK: - Setup Page Controllers
private extension OnboardingPageViewController {
    func setupViewControllers() {
        let maxPages = 3
        
        let page1 = OnboardingViewController(
            imageName: K.Onboarding.imagePage1.rawValue,
            primatyText: K.Onboarding.primaryTextPage1.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage1.rawValue,
            buttonTitle: K.Onboarding.continueButtonTitle.rawValue,
            page: 0,
            totalPages: maxPages
        )
        
        let page2 = OnboardingViewController(
            imageName: K.Onboarding.imagePage2.rawValue,
            primatyText: K.Onboarding.primaryTextPage2.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage2.rawValue,
            buttonTitle: K.Onboarding.continueButtonTitle.rawValue,
            page: 1,
            totalPages: maxPages
        )
        
        let page3 = OnboardingViewController(
            imageName: K.Onboarding.imagePage3.rawValue,
            primatyText: K.Onboarding.primaryTextPage3.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage3.rawValue,
            buttonTitle: K.Onboarding.startCooking.rawValue,
            page: 2,
            totalPages: maxPages
        )
        
        page1.delegate = self
        page2.delegate = self
        page3.delegate = self
        
        pages = [page1, page2, page3]
        
        /// set start view controller
        if let firstPage = pages.first, pages.count == maxPages {
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
extension OnboardingPageViewController: OnboardingPageViewProtocol {
    func showSpecificPage(_ page: Int) {
        presenter.showSpecificPage(page)
    }
    
    func showNextPage() {
        presenter.showNextPage()
    }
    
    func showStartVC() {
        presenter.showStartVC()
    }
}
