//
//  DetailTableViewCell.swift
//  BestRecipes
//
//  Created by Pavel Kostin on 04.07.2024.
//

import UIKit


final class DetailViewCell: UITableViewCell {
    
    static let identifier = "DetailViewCell"
    
    private let ingredientImage = UIImageView()
    private let nameLabel = UILabel()
    private let units = UILabel()
    private let containerView = UIView()
    private let checkBox = DetailCheckBox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraint()
        setupConfigure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailViewCell {
    
    private func setupView() {
        
        contentView.addSubview(containerView)
        containerView.addSubviews([ingredientImage, nameLabel, checkBox, units])
    }
    
    private func setupConstraint() {
        
        ingredientImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        units.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            ingredientImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            ingredientImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: ingredientImage.trailingAnchor, constant: 16),
            
            checkBox.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkBox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            checkBox.heightAnchor.constraint(equalToConstant: 23),
            checkBox.widthAnchor.constraint(equalToConstant: 23),
            
            units.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            units.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -27)
            
        ])
    }
    
    private func setupConfigure() {
        containerView.backgroundColor = #colorLiteral(red: 0.9562537074, green: 0.9562535882, blue: 0.9562537074, alpha: 1)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        
        ingredientImage.contentMode = .scaleAspectFit
        ingredientImage.layer.masksToBounds = true
        ingredientImage.layer.cornerRadius = 7
        
        nameLabel.font = Font.getFont(.poppinsBold, size: 16)
        
        units.font = Font.getFont(.poppinsRegular, size: 14)
        units.textColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6352941176, alpha: 1)
    }
    
    func configure(with ingredient: DetailIngredient) {
        nameLabel.text = ingredient.name
        units.text = "\(ingredient.amount)g"
//        ingredientImage.loadImage2(from: ingredient.imageName) func getImage
    }
}
