//
//  TrendingViewCell.swift
//  BestRecipes
//
//  Created by realeti on 13.07.2024.
//

import UIKit

protocol TrendingViewCellProtocol: AnyObject {
    func loadImage(for indexPath: IndexPath)
    func saveRecipe(at indexPath: IndexPath, imageData: Data)
}

final class TrendingViewCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let recipeImageView = UIImageView(
        contentMode: .scaleAspectFill,
        cornerRadius: 12
    )
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .greyDark
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ratingStarImageView = UIImageView(
        image: .star,
        contentMode: .scaleAspectFit
    )
    
    private let ratingLabel = UILabel(
        font: .poppinsBold,
        fontSize: 14.0
    )
    
    private lazy var recipeSaveContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        /// corner radius
        view.layer.cornerRadius = Metrics.recipeSaveContainerSize / 2
        view.layer.masksToBounds = true
        
        /// shadow
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowRadius = 25
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 1.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeSaveButton: UIButton = {
        let button = UIButton(type: .system)
        let action = UIAction { _ in
            self.delegate?.saveRecipe(
                at: self.indexPath ?? IndexPath(),
                imageData: self.recipeImageData ?? Data()
            )
        }
        
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var timeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .greyDark
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel = UILabel(
        font: .poppinsRegular,
        fontSize: 12.0
    )
    
    private lazy var recipeTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel = UILabel(
        color: .blackBase,
        font: .poppinsBold,
        fontSize: 17.0
    )
    
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let authorImageView = UIImageView(
        contentMode: .scaleAspectFill,
        cornerRadius: Metrics.authorImageSize / 2
    )
    
    private let authorNameLabel = UILabel (
        color: .greyBase,
        font: .poppinsRegular,
        fontSize: 12.0
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Public Properties
    weak var delegate: TrendingViewCellProtocol?
    var indexPath: IndexPath?
    var recipeImageData: Data?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImageView.image = nil
        ratingLabel.text = nil
        timeLabel.text = nil
        titleLabel.text = nil
        authorImageView.image = nil
        authorNameLabel.text = nil
        recipeSaveButton.setBackgroundImage(nil, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.addSubviews(recipeImageView, ratingStackView, recipeSaveContainer, timeContainer, activityIndicator)
        ratingStackView.addArrangedSubviews(ratingStarImageView, ratingLabel)
        recipeSaveContainer.addSubview(recipeSaveButton)
        timeContainer.addSubview(timeLabel)
        
        containerView.addSubview(recipeTitleStackView)
        recipeTitleStackView.addArrangedSubviews(titleLabel, authorStackView)
        authorStackView.addArrangedSubviews(authorImageView, authorNameLabel)
    }
    
    // MARK: - Show Loading indicator
    func showLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    /*func setupMockData() {
        recipeImageView.image = UIImage(resource: .searchFood2)
        ratingLabel.text = "5.0"
        timeLabel.text = "15:10"
        titleLabel.text = "How to make sharwama at home"
        authorImageView.image = UIImage(resource: .author)
        authorNameLabel.text = "By Zeelicious Foods"
    }*/
}

// MARK: - Configure Cell
extension TrendingViewCell {
    func configure(with config: TrendingCellConfiguration) {
        titleLabel.text = config.title
        ratingLabel.text = String(format: "%.1f", config.rating)
        timeLabel.text = config.recipeMinutes
        authorNameLabel.text = config.authorName
        indexPath = config.indexPath
        
        setupSaveButtonImage(isRecipeSaved: config.isRecipeSaved)
        setupAuthorImage()
        delegate?.loadImage(for: config.indexPath)
    }
    
    func updateRecipeImage(with imageData: Data) {
        if !imageData.isEmpty {
            recipeImageData = imageData
            recipeImageView.image = UIImage(data: imageData)
        } else {
            recipeImageView.image = UIImage(resource: .noimage)
        }
    }
    
    func updateSaveButtonImage(isRecipeSaved: Bool) {
        let newImage: UIImage = isRecipeSaved ? .favoritesActive : .favoritesInactive
        UIView.transition(with: recipeSaveButton, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.recipeSaveButton.setBackgroundImage(newImage, for: .normal)
        }, completion: nil)
    }
    
    private func setupSaveButtonImage(isRecipeSaved: Bool) {
        let saveButtonImage: UIImage = isRecipeSaved ? .favoritesActive : .favoritesInactive
        recipeSaveButton.setBackgroundImage(saveButtonImage, for: .normal)
    }
    
    private func setupAuthorImage() {
        let images: [UIImage] = [.author, .author2]
        authorImageView.image = images.randomElement() ?? UIImage()
    }
}

// MARK: - Actions
extension TrendingViewCell {
    @objc private func saveButtonPressed(_ sender: UIButton) {
        delegate?.saveRecipe(
            at: self.indexPath ?? IndexPath(),
            imageData: self.recipeImageData ?? Data()
        )
    }
}

// MARK: - Setup Constraints
extension TrendingViewCell {
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupRecipeImageConstraints()
        setupRatingStackViewConstraints()
        setupRatingStarImageConstraints()
        setupRecipeSaveContainerConstraints()
        setupRecipeSaveButtonConstraints()
        setupTimeContainerConstraints()
        setupTimeLabelConstraints()
        setupRecipeTitleStackConstraints()
        setupAuthorImageViewConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.52)
        ])
    }
    
    private func setupRatingStackViewConstraints() {
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalToSystemSpacingBelow: recipeImageView.topAnchor, multiplier: 1.0),
            ratingStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: recipeImageView.leadingAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupRatingStarImageConstraints() {
        NSLayoutConstraint.activate([
            ratingStarImageView.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize),
            ratingStarImageView.widthAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
    
    private func setupRecipeSaveContainerConstraints() {
        NSLayoutConstraint.activate([
            recipeSaveContainer.topAnchor.constraint(equalToSystemSpacingBelow: recipeImageView.topAnchor, multiplier: 1.0),
            recipeImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: recipeSaveContainer.trailingAnchor, multiplier: 1.0),
            recipeSaveContainer.widthAnchor.constraint(equalToConstant: Metrics.recipeSaveContainerSize),
            recipeSaveContainer.heightAnchor.constraint(equalToConstant: Metrics.recipeSaveContainerSize)

        ])
    }
    
    private func setupRecipeSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            recipeSaveButton.centerXAnchor.constraint(equalTo: recipeSaveContainer.centerXAnchor),
            recipeSaveButton.centerYAnchor.constraint(equalTo: recipeSaveContainer.centerYAnchor),
            recipeSaveButton.widthAnchor.constraint(equalToConstant: Metrics.recipeSaveButtonSize),
            recipeSaveButton.heightAnchor.constraint(equalToConstant: Metrics.recipeSaveButtonSize)
        ])
    }
    
    private func setupTimeContainerConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: timeContainer.trailingAnchor, multiplier: 1.0),
            recipeImageView.bottomAnchor.constraint(equalToSystemSpacingBelow: timeContainer.bottomAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: timeContainer.topAnchor, constant: Metrics.timeHorizontalIndent),
            timeLabel.leadingAnchor.constraint(equalTo: timeContainer.leadingAnchor, constant: Metrics.timeVerticalIndent),
            timeLabel.trailingAnchor.constraint(equalTo: timeContainer.trailingAnchor, constant: -Metrics.timeVerticalIndent),
            timeLabel.bottomAnchor.constraint(equalTo: timeContainer.bottomAnchor, constant: -Metrics.timeHorizontalIndent)
        ])
    }
    
    private func setupRecipeTitleStackConstraints() {
        NSLayoutConstraint.activate([
            recipeTitleStackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: Metrics.titleStackTopIndent),
            recipeTitleStackView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: recipeTitleStackView.trailingAnchor, multiplier: 1.0),
            recipeTitleStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupAuthorImageViewConstraints() {
        NSLayoutConstraint.activate([
            authorImageView.heightAnchor.constraint(equalToConstant: Metrics.authorImageSize),
            authorImageView.widthAnchor.constraint(equalToConstant: Metrics.authorImageSize)
        ])
    }
}

// MARK: - Trending Cell Configuration
struct TrendingCellConfiguration {
    let title: String
    let rating: Double
    let recipeMinutes: String
    let authorName: String
    let isRecipeSaved: Bool
    let indexPath: IndexPath
}

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
    static let recipeSaveContainerSize: CGFloat = 32.0
    static let recipeSaveButtonSize: CGFloat = 20.5
    static let authorImageSize: CGFloat = 32.0
    
    static let titleStackTopIndent: CGFloat = 12.0
    static let timeHorizontalIndent: CGFloat = 4.0
    static let timeVerticalIndent: CGFloat = 7.0
}
