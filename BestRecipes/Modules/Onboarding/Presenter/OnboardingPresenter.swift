//
//  OnboardingPresenter.swift
//  BestRecipes
//
//  Created by realeti on 23.07.2024.
//

import Foundation

protocol OnboadringViewProtocol: AnyObject {
    func startButtonPressed()
}

protocol OnboardingPresenterProtocol: AnyObject {
    init(view: OnboadringViewProtocol, router: RouterProtocol)
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    // MARK: - Private Properties
    private let router: RouterProtocol
    weak var view: OnboadringViewProtocol?
    
    // MARK: - Init
    required init(view: OnboadringViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
