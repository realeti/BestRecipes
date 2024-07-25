//
//  OnboardingPresenter.swift
//  BestRecipes
//
//  Created by realeti on 23.07.2024.
//

import Foundation

protocol OnboardingHomeViewProtocol: AnyObject {
    func startButtonPressed()
}

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboardingHomeViewProtocol, router: RouterProtocol)
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    // MARK: - Private Properties
    private let router: RouterProtocol
    weak var view: OnboardingHomeViewProtocol?
    
    // MARK: - Init
    required init(view: OnboardingHomeViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
