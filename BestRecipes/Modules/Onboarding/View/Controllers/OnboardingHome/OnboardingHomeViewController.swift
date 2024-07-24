//
//  OnboardingHomeViewController.swift
//  BestRecipes
//
//  Created by realeti on 23.07.2024.
//

import UIKit

final class OnboardingHomeViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Private Properties
    private var onboardingView: OnboardingHomeView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        onboardingView = OnboardingHomeView()
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
extension OnboardingHomeViewController: OnboadringViewProtocol {
    func startButtonPressed() {
        print("Get started button pressed")
        /*let onboardingPageVC = OnboardingPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )*/
        let onboardingPageVC = OnboardingPageViewController()
        
        onboardingPageVC.modalPresentationStyle = .fullScreen
        present(onboardingPageVC, animated: true)
    }
}
