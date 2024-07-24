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
    private var imageName = ""
    private var primaryText = ""
    private var secondaryText = ""
    private var page: Int = 0
    
    // MARK: - Init
    init(imageName: String, primatyText: String, secondaryText: String, page: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.imageName = imageName
        self.primaryText = primatyText
        self.secondaryText = secondaryText
        self.page = page
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
            imageName: imageName,
            primaryText: primaryText,
            secondaryText: secondaryText,
            page: page
        )
    }
}
