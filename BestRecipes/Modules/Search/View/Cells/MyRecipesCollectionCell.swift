//
//  MyRecipesCollectionCell.swift
//  BestRecipes
//
//  Created by realeti on 09.07.2024.
//

import UIKit

protocol SearchViewCellProtocol: AnyObject {
    func loadImage(for cell: MyRecipesCollectionCell, at indexPath: IndexPath)
}

final class MyRecipesCollectionCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
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
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let descriptionTitleLabel = UILabel(
        font: .poppinsBold,
        fontSize: 19.0,
        numberOfLines: 2
    )
    
    private let ingredientsLabel = UILabel(
        font: .poppinsRegular,
        fontSize: 15.0
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Public Properties
    weak var delegate: SearchViewCellProtocol?
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImageView.image = nil
        descriptionTitleLabel.text = nil
        ingredientsLabel.text = nil
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews(containerView, ratingStackView, descriptionStackView)
        ratingStackView.addArrangedSubviews(ratingStarImageView, ratingLabel)
        descriptionStackView.addArrangedSubviews(descriptionTitleLabel, ingredientsLabel)
        containerView.addSubviews(recipeImageView, activityIndicator)
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
}

// MARK: - Configure Cell
extension MyRecipesCollectionCell {
    func configure(with config: SearchCellConfiguration) {
        self.indexPath = config.indexPath
        
        ratingLabel.text = String(format: "%.1f", config.rating)
        descriptionTitleLabel.text = config.title
        ingredientsLabel.text = "\(config.ingredientsCount) Ingredients | \(config.recipeMinutes) min"
        delegate?.loadImage(for: self, at: config.indexPath)
    }
    
    func updateRecipeImage(with imageData: Data) {
        self.recipeImageData = imageData
        recipeImageView.image = UIImage(data: imageData)
    }
}

// MARK: - Setup Constraints
extension MyRecipesCollectionCell {
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupRecipeImageConstraints()
        setupRatingStackViewConstraints()
        setupRatingStarImageConstraints()
        setupDescriptionStackViewConstraints()
        setupActivityIndicatorConstraints()
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
            recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -70),
            recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 70),
            recipeImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupRatingStackViewConstraints() {
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.0),
            ratingStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupRatingStarImageConstraints() {
        NSLayoutConstraint.activate([
            ratingStarImageView.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize),
            ratingStarImageView.widthAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
    
    private func setupDescriptionStackViewConstraints() {
        NSLayoutConstraint.activate([
            descriptionStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionStackView.trailingAnchor, multiplier: 5.0),
            bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionStackView.bottomAnchor, multiplier: 2.0)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: - Search Cell Configuration
struct SearchCellConfiguration {
    let rating: Double
    let title: String
    let ingredientsCount: Int
    let recipeMinutes: Int
    let indexPath: IndexPath
}

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
}
