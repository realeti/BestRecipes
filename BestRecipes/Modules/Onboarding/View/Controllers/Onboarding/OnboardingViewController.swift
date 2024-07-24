//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - Private Properties
    private var onboardingView: OnboardingView!
    //private let imageName: String
    //private let primaryText: String
    //private let secondaryText: String
    
    // MARK: - Init
    init(imageName: String, primatyText: String, secondaryText: String) {
        super.init(nibName: nil, bundle: nil)
        
        //self.imageName = imageName
        //self.primaryText = primatyText
        //self.secondaryText = secondaryText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        onboardingView = OnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView.configure(
            imageName: K.Onboarding.imagePage1.rawValue,
            primaryText: K.Onboarding.primaryTextPage1.rawValue,
            secondaryText: K.Onboarding.secondaryTextPage1.rawValue,
            page: 0
        )
    }
}
