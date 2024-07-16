//
//  DetailViewCell.swift
//  BestRecipes
//
//  Created by realet on 16.07.2024.
//

import UIKit

final class DetailViewCell: UITableViewCell {
    // MARK: - UI
    private let baseView = UIView(
        backgroundColor: .greyLighter,
        cornerRadius: 12.0
    )
    
    private let mainStack = UIStackView(
        axis: .horizontal,
        spacing: 16.0,
        distribution: .fill
    )
    
    private let ingredientImageContent = UIView(
        backgroundColor: .white,
        cornerRadius: 8.0
    )
    
    private let ingredientImageView = UIImageView(contentMode: .scaleAspectFit)
    
    private let ingredientNameLabel = UILabel(
        color: .blackBase,
        font: .poppinsBold,
        fontSize: 16.0
    )
    
    private let ingredientGramLabel = UILabel(
        color: .greyBase,
        font: .poppinsRegular,
        fontSize: 14.0
    )
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ingredientImageView.image = nil
        ingredientNameLabel.text = nil
        ingredientGramLabel.text = nil
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubviews(
            ingredientImageContent,
            ingredientNameLabel,
            ingredientGramLabel
        )
        
        ingredientImageContent.addSubview(ingredientImageView)
    }
}

// MARK: - Configure UI
extension DetailViewCell {
    private func configureUI() {
        contentView.backgroundColor = .white
    }
}

// MARK: - Configure Cell
extension DetailViewCell {
    func configure(name: String, gram: String) {
        ingredientNameLabel.text = name
        ingredientGramLabel.text = gram
    }
}

// MARK: - Setup Constraints
extension DetailViewCell {
    private func setupConstraints() {
        setupBaseViewConstraints()
        setupMainStackConstraints()
        setupIngredientImageViewConstraints()
    }
    
    private func setupBaseViewConstraints() {
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
        ])
    }
    
    private func setupMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    private func setupIngredientImageViewConstraints() {
        NSLayoutConstraint.activate([
            ingredientImageView.centerXAnchor.constraint(equalTo: ingredientImageContent.centerXAnchor),
            ingredientImageView.centerYAnchor.constraint(equalTo: ingredientImageContent.centerYAnchor)
        ])
    }
}
