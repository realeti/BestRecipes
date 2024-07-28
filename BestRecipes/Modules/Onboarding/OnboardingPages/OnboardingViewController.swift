//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func pageControlPressed(page: Int)
    func continueButtonPressed()
    func skipButtonPressed()
}

final class OnboardingViewController: UIViewController {
    // MARK: - Private Properties
    private var onboardingView: OnboardingView!
    private let imageName: String
    private let primaryText: String
    private let secondaryText: String
    private let buttonTitle: String
    private let currentPage: Int
    private let totalPages: Int
    
    // MARK: - Public Properties
    weak var delegate: OnboardingPageViewProtocol?
    
    // MARK: - Init
    init(imageName: String, primatyText: String, secondaryText: String, buttonTitle: String, page: Int, totalPages: Int) {
        self.imageName = imageName
        self.primaryText = primatyText
        self.secondaryText = secondaryText
        self.buttonTitle = buttonTitle
        self.currentPage = page
        self.totalPages = totalPages
        
        super.init(nibName: nil, bundle: nil)
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
        
        configureUI()
        setDelegates()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        onboardingView.configure(
            imageName: imageName,
            primaryText: primaryText,
            secondaryText: secondaryText,
            buttonTitle: buttonTitle,
            page: currentPage,
            totalPages: totalPages
        )
    }
}

// MARK: - Set Delegates
private extension OnboardingViewController {
    func setDelegates() {
        onboardingView.delegate = self
    }
}

// MARK: - OnboardingView Delegate methods
extension OnboardingViewController: OnboardingViewProtocol {
    func pageControlPressed(page: Int) {
        delegate?.showSpecificPage(page)
    }
    
    func continueButtonPressed() {
        delegate?.showNextPage()
    }
    
    func skipButtonPressed() {
        delegate?.showStartVC()
    }
}
