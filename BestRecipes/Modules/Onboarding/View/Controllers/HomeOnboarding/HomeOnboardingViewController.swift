//
//  HomeOnboardingViewController.swift
//  BestRecipes
//
//  Created by realeti on 23.07.2024.
//

import UIKit

final class HomeOnboardingViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Private Properties
    private var onboardingView: HomeOnboardingView!
    
    // MARK: - Init
    override func loadView() {
        super.loadView()
        
        onboardingView = HomeOnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        onboardingView.delegate = self
    }
}

// MARK: - OnboardingView Delegate
extension HomeOnboardingViewController: OnboadringViewProtocol {
    func getStartedButtonPressed() {
        print("Get started button pressed")
    }
}
