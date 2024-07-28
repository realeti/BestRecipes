//
//  OnboardingHomeView.swift
//  BestRecipes
//
//  Created by realeti on 23.07.2024.
//

import UIKit

final class OnboardingHomeView: UIView {
    // MARK: - UI
    private let backgroundImageView = UIImageView(
        image: .homeOnboarding,
        contentMode: .scaleAspectFill
    )
    
    private let titleStackView = UIStackView(
        axis: .horizontal,
        spacing: 0,
        distribution: .fill
    )
    
    private let starImageView = UIImageView(
        image: .star,
        contentMode: .scaleAspectFill
    )
    
    private let titleSpacerView = UIView()
    
    private let countRecipesLabel = UILabel(
        text: K.Onboarding.recipesCount.rawValue,
        font: .poppinsSemiBold,
        fontSize: 16.0
    )
    
    private let premiumRecipesLabel = UILabel(
        text: K.Onboarding.premiumRecipes.rawValue,
        font: .poppinsRegular,
        fontSize: 16.0
    )
    
    private let bottomStackView = UIStackView(
        axis: .vertical,
        spacing: 15.0,
        distribution: .fill
    )
    
    private let bestRecipeLabel = UILabel(
        text: K.Onboarding.bestRecipe.rawValue,
        font: .poppinsSemiBold,
        fontSize: 56.0,
        alignment: .center,
        numberOfLines: 2
    )
    
    private let findBestRecipesLabel = UILabel(
        text: K.Onboarding.findBestRecipes.rawValue,
        font: .poppinsRegular,
        fontSize: 16.0,
        alignment: .center
    )
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSAttributedString(
            string: K.Onboarding.startButtonTitle.rawValue,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: Font.getFont(.poppinsSemiBold, size: 16.0)
            ]
        )
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = .redBase
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var gradientView: HomeGradientView = {
        let view = HomeGradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Public Properties
    weak var delegate: OnboardingHomeViewProtocol?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        backgroundColor = .systemGreen
        
        addSubviews(
            backgroundImageView,
            titleStackView,
            gradientView,
            startButton,
            bottomStackView
        )
        
        titleStackView.addArrangedSubviews(
            starImageView,
            titleSpacerView,
            countRecipesLabel,
            premiumRecipesLabel
        )
        
        bottomStackView.addArrangedSubviews(
            bestRecipeLabel,
            findBestRecipesLabel
        )
    }
}

// MARK: - Actions
private extension OnboardingHomeView {
    @objc func startButtonPressed(_ sender: UIButton) {
        delegate?.startButtonPressed()
    }
}

// MARK: - Setup Constraints
private extension OnboardingHomeView {
    func setupConstraints() {
        setupBackgroundImageConstraints()
        setupRecipeTitleStackConstraints()
        setupStarImageConstraints()
        setupTitleSpacerViewConstraints()
        setupGradientViewConstraints()
        setupStartButtonConstraints()
        setupBottomStackViewConstraints()
    }
    
    func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupRecipeTitleStackConstraints() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2.0),
            titleStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupStarImageConstraints() {
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: Metrics.starIconSize),
            starImageView.heightAnchor.constraint(equalToConstant: Metrics.starIconSize)
        ])
    }
    
    func setupTitleSpacerViewConstraints() {
        NSLayoutConstraint.activate([
            titleSpacerView.widthAnchor.constraint(equalToConstant: Metrics.spacerViewWidth),
            titleSpacerView.heightAnchor.constraint(equalToConstant: Metrics.starIconSize)
        ])
    }
    
    func setupGradientViewConstraints() {
        NSLayoutConstraint.activate([
            gradientView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupStartButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.bottomIndent),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: Metrics.startButtonWidth),
            startButton.heightAnchor.constraint(equalToConstant: Metrics.startButtonHeight)
        ])
    }
    
    func setupBottomStackViewConstraints() {
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalToSystemSpacingBelow: bottomStackView.bottomAnchor, multiplier: 4.0),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

fileprivate struct Metrics {
    static let starIconSize: CGFloat = 16.0
    static let spacerViewWidth: CGFloat = 8.0
    static let startButtonWidth: CGFloat = 156.0
    static let startButtonHeight: CGFloat = 56.0
    
    static let bottomIndent: CGFloat = 82
}
