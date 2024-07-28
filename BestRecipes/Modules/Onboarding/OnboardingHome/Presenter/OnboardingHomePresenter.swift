//
//  OnboardingHomePresenter.swift
//  BestRecipes
//
//  Created by realeti on 28.07.2024.
//

import Foundation

protocol OnboardingHomeViewProtocol: AnyObject {
    func startButtonPressed()
}

protocol OnboardingHomePresenterProtocol: AnyObject {
    init(view: OnboardingHomeViewProtocol, router: OnboardingRouter)
    func showOnboardingPages()
}

final class OnboardingHomePresenter: OnboardingHomePresenterProtocol {
    // MARK: - Private Properties
    private let router: OnboardingRouter
    private weak var view: OnboardingHomeViewProtocol?
    
    // MARK: - Init
    init(view: OnboardingHomeViewProtocol, router: OnboardingRouter) {
        self.view = view
        self.router = router
    }
}

// MARK: - Show Onboarding Pages
extension OnboardingHomePresenter {
    func showOnboardingPages() {
        router.start()
    }
}
