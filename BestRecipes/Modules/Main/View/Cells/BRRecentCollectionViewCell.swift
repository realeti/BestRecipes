//
//  BRRecentCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRRecentCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let foodImageView: UIImageView = {
        $0.image = .food3
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "Kelewele Ghanian Recipe"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 14)
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let authorNameLabel: UILabel = {
        $0.text = "By Zeelicious foods"
        $0.textColor = .greyBase
        $0.font = Font.getFont(.poppinsRegular, size: 10)
        $0.numberOfLines = 1
//        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Properties
    
    static let idCell = "BRRecentCollectionViewCell"
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        setCostraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension BRRecentCollectionViewCell {
    func configureCell(image: UIImage, title: String, authorName: String) {
        foodImageView.image = image
        titleLabel.text = title
        authorNameLabel.text = authorName
    }
}


//MARK: - Internal Methods

private extension BRRecentCollectionViewCell {
    func configure() {
        addSubviews(foodImageView,
                    titleLabel,
                    authorNameLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            foodImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 124),
            foodImageView.widthAnchor.constraint(equalToConstant: 124),
            
            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 5),
            authorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
