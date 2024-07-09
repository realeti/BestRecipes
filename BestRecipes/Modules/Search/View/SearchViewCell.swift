//
//  SearchViewCell.swift
//  BestRecipes
//
//  Created by realeti on 09.07.2024.
//

import UIKit

final class SearchViewCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var recipeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .greyDark
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ratingStarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .star
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5.0"
        label.textColor = .white
        label.font = Font.getFont(.poppinsBold, size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "How to make yam & vegetable sauce at home"
        label.textColor = .white
        label.font = Font.getFont(.poppinsBold, size: 16.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "9 Ingredients | 25 min"
        label.textColor = .white
        label.font = Font.getFont(.poppinsRegular, size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        contentView.addSubviews(recipeImageView, ratingStackView, descriptionStackView)
        ratingStackView.addArrangedSubviews(ratingStarImageView, ratingLabel)
        descriptionStackView.addArrangedSubviews(descriptionTitleLabel, ingredientsLabel)
    }
}

// MARK: - Configure Cell
extension SearchViewCell {
    func configure() {
        let mockImages: [UIImage] = [.searchFood1, .searchFood2, .searchFood3]
        recipeImageView.image = mockImages.randomElement() ?? UIImage()
    }
}

// MARK: - Setup Constraints
extension SearchViewCell {
    private func setupConstraints() {
        setupRecipeImageConstraints()
        setupRatingStackViewConstraints()
        setupRatingStarImageConstraints()
        setupDescriptionStackViewConstraints()
    }
    
    private func setupRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
    
    private func setupDescriptionStackViewConstraints() {
        NSLayoutConstraint.activate([
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
        ])
    }
}

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
}
