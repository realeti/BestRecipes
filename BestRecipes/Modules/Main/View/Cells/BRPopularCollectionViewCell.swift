//
//  BRPopularCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRPopularCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let backgroundCellView: UIView = {
        $0.backgroundColor = .greyLighter
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let foodImageView: UIImageView = {
        $0.image = .food1
        $0.layer.cornerRadius = 55
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "Chicken and Vegetable wrap"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let timeLabel: UILabel = {
        $0.text = "Time"
        $0.textColor = .greyLight
        $0.font = Font.getFont(.poppinsRegular, size: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let minutesLabel: UILabel = {
        $0.text = "5 Mins"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var favoritesButton = BRFavoritesButton()
    
    
    //MARK: - Properties
    
    static let idCell = "BRPopularCollectionViewCell"
    
    
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

extension BRPopularCollectionViewCell {
    func configureCell(image: UIImage, title: String, time: String) {
        foodImageView.image = image
        titleLabel.text = title
        minutesLabel.text = time
    }
}


//MARK: - Internal Methods

private extension BRPopularCollectionViewCell {
    func configure() {
        addSubviews(backgroundCellView, foodImageView,
                    titleLabel,
                    timeLabel, minutesLabel, favoritesButton)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            foodImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 110),
            foodImageView.widthAnchor.constraint(equalToConstant: 110),
            
            backgroundCellView.topAnchor.constraint(equalTo: foodImageView.centerYAnchor),
            backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleLabel.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10),
            timeLabel.widthAnchor.constraint(equalToConstant: 35),
            
            minutesLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            minutesLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            minutesLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -10),
            
            favoritesButton.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -10),
            favoritesButton.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -10),
            favoritesButton.heightAnchor.constraint(equalToConstant: 32),
            favoritesButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
