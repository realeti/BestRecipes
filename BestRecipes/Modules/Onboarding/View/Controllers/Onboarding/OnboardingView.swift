//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by realeti on 24.07.2024.
//

import UIKit

final class OnboardingView: UIView {
    // MARK: - UI
    private let backgroundImageView = UIImageView(
        contentMode: .scaleAspectFill
    )
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.42)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.preferredIndicatorImage = .pageIndicatorInactive
        pageControl.preferredCurrentPageIndicatorImage = .pageIndicatorActive
        pageControl.pageIndicatorTintColor = .greyBorder
        pageControl.currentPageIndicatorTintColor = .lightRose
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .redBase
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSAttributedString(
            string: K.Onboarding.skipButtonTitle.rawValue,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: Font.getFont(.interMedium, size: 14.0)
            ]
        )
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public Properties
    weak var delegate: OnboardingViewProtocol?
    var currentPage = 0
    
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
        addSubviews(
            backgroundImageView,
            shadowView,
            skipButton,
            continueButton,
            pageControl,
            titleLabel
        )
    }
}

// MARK: - Public Configure UI
extension OnboardingView {
    func configure(imageName: String, primaryText: String, secondaryText: String, buttonTitle: String, page: Int) {
        configureBackgroundImage(imageName)
        configureTitleLabel(with: primaryText, and: secondaryText)
        configureContinueButton(title: buttonTitle)
        configurePageControl(page)
        configreSkipButton(with: page)
    }
    
    private func configureBackgroundImage(_ imageName: String) {
        backgroundImageView.image = UIImage(named: imageName) ?? UIImage(resource: .noimage)
    }
    
    private func configureTitleLabel(with primaryText: String, and secondaryText: String) {
        let primaryAttributedString = NSMutableAttributedString(
            string: primaryText,
            attributes: [
                .font: Font.getFont(.poppinsSemiBold, size: 40.0),
                .foregroundColor: UIColor.white
            ]
        )
        
        let secondaryAttributedString = NSMutableAttributedString(
            string: secondaryText,
            attributes: [
                .font: Font.getFont(.poppinsSemiBold, size: 40.0),
                .foregroundColor: UIColor.beigeBase
            ]
        )
        
        primaryAttributedString.append(secondaryAttributedString)
        titleLabel.attributedText = primaryAttributedString
    }
    
    private func configureContinueButton(title: String) {
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: Font.getFont(.poppinsMedium, size: 20.0)
            ]
        )
        continueButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func configurePageControl(_ page: Int) {
        currentPage = page
        pageControl.currentPage = page
    }
    
    private func configreSkipButton(with page: Int) {
        if page == 2 {
            skipButton.isHidden = true
        } else {
            skipButton.isHidden = false
        }
    }
}

// MARK: - Actions
private extension OnboardingView {
    @objc func pageControlPressed(_ sender: UIPageControl) {
        delegate?.pageControlPressed(page: sender.currentPage)
        
        /// return current page value
        DispatchQueue.main.async {
            self.pageControl.currentPage = self.currentPage
        }
    }
    
    @objc func continueButtonPressed(_ sender: UIButton) {
        delegate?.continueButtonPressed()
    }
    
    @objc func skipButtonPressed(_ sender: UIButton) {
        delegate?.skipButtonPressed()
    }
}

// MARK: - Setup Constraints
private extension OnboardingView {
    func setupConstraints() {
        setupBackgroundImageConstraints()
        setupShadowViewConstraints()
        setupSkipButtonConstraints()
        setupContinueButtonConstraints()
        setupPageControlConstraints()
        setupTitleLabelConstraints()
    }
    
    func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupSkipButtonConstraints() {
        NSLayoutConstraint.activate([
            skipButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: skipButton.bottomAnchor, multiplier: 0.5)
        ])
    }
    
    func setupContinueButtonConstraints() {
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -Metrics.continueButtonIndent),
            continueButton.widthAnchor.constraint(equalToConstant: Metrics.continueButtonWidth),
            continueButton.heightAnchor.constraint(equalToConstant: Metrics.continueButtonHeight)
        ])
    }
    
    func setupPageControlConstraints() {
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.topAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 4.0)
        ])
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 4.0),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 3.0)
        ])
    }
}

fileprivate struct Metrics {
    static let continueButtonWidth: CGFloat = 193.0
    static let continueButtonHeight: CGFloat = 44.0
    static let continueButtonIndent: CGFloat = 12.0
}
