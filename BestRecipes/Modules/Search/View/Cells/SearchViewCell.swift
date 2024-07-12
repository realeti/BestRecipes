//
//  SearchViewCell.swift
//  BestRecipes
//
//  Created by realeti on 09.07.2024.
//

import UIKit

protocol SearchViewCellProtocol: AnyObject {
    func loadImage(for cell: SearchViewCell, at indexPath: IndexPath)
}

final class SearchViewCell: UICollectionViewCell {
    // MARK: - UI
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
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
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
        text: "5.0",
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
        text: "How to make yam & vegetable sauce at home",
        font: .poppinsBold,
        fontSize: 16.0,
        numberOfLines: 2
    )
    
    private let ingredientsLabel = UILabel(
        text: "9 Ingredients | 25 min",
        font: .poppinsRegular,
        fontSize: 12.0
    )
    
    // MARK: - Public Properties
    weak var delegate: SearchViewCellProtocol?
    var indexPath: IndexPath?
    
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
    func configure(_ title: String, _ ingredientsCount: Int, _ recipeMinutes: Int, for indexPath: IndexPath) {
        /*let mockImages: [UIImage] = [
            .searchFood1,
            .searchFood2,
            .searchFood3,
            .food1,
            .food2,
            .food3,
            .food4
        ]*/
        //recipeImageView.image = mockImages.randomElement() ?? UIImage()
        self.indexPath = indexPath
        
        descriptionTitleLabel.text = title
        ingredientsLabel.text = "\(ingredientsCount) Ingredients | \(recipeMinutes) min"
        
        delegate?.loadImage(for: self, at: indexPath)
    }
    
    func updateRecipeImage(with imageData: Data) {
        recipeImageView.image = UIImage(data: imageData)
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
            descriptionStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionStackView.trailingAnchor, multiplier: 2.0),
            bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionStackView.bottomAnchor, multiplier: 2.0)
        ])
    }
}

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
}
