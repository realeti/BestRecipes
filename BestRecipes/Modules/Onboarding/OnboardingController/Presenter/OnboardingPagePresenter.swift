//
//  OnboardingControllerPresenter.swift
//  BestRecipes
//
//  Created by realeti on 28.07.2024.
//

import Foundation

protocol OnboardingPageViewProtocol: AnyObject {
    func showSpecificPage(_ page: Int)
    func showNextPage()
    func showStartVC()
}

protocol OnboardingPagePresenterProtocol {
    init(view: OnboardingPageViewProtocol, router: OnboardingRouter)
    
    func updateCurrentPage(to page: Int)
    func showSpecificPage(_ page: Int)
    func showNextPage()
    func showStartVC()
}

final class OnboardingPagePresenter: OnboardingPagePresenterProtocol {
    // MARK: - Private Properties
    private let router: OnboardingRouter
    private weak var view: OnboardingPageViewProtocol?
    
    // MARK: - Init
    init(view: OnboardingPageViewProtocol, router: OnboardingRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - Presenter Delegate methods
extension OnboardingPagePresenter {
    func updateCurrentPage(to page: Int) {
        router.updateCurrentPage(to: page)
    }
    
    func showSpecificPage(_ page: Int) {
        router.showSpecificPage(at: page)
    }
    
    func showNextPage() {
        router.showNextPage()
    }
    
    func showStartVC() {
        router.showStartVC()
    }
}
