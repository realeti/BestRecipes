//
//  TrendingTableViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class TrendingTableViewCell: UITableViewCell {
    
    //MARK: - UI
    
    private let backgroundImageView: UIImageView = {
        $0.image = .media
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    public lazy var favoritesButton = BRFavoritesButton()
    
    private let ratingView = BRRatingView()
    
    private let titleLabel: UILabel = {
        $0.text = "How to sharwama at home"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 16)
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let authorImageView: UIImageView = {
        $0.image = .author
        $0.layer.cornerRadius = 16
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let authorNameLabel: UILabel = {
        $0.text = "By Zeelicious foods"
        $0.textColor = .greyBase
        $0.font = Font.getFont(.poppinsRegular, size: 14)
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BRTrendingTableViewCell")
        
        
        configure()
        setCostraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension TrendingTableViewCell {
    func configureCell(rating: String, image: UIImage, title: String, authorImage: UIImage, author: String, index: IndexPath) {
        ratingView.rateLabel.text = rating
        backgroundImageView.image = image
        titleLabel.text = title
        authorImageView.image = authorImage
        authorNameLabel.text = author
        favoritesButton.tag = index.item
    }
}


//MARK: - Internal Methods

private extension TrendingTableViewCell {
    
    //MARK: - Setup UI
    
    func configure() {
        addSubviews(backgroundImageView,
                    ratingView, favoritesButton,
                    titleLabel,
                    authorImageView, authorNameLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -75),
            
            ratingView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            ratingView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            ratingView.heightAnchor.constraint(equalToConstant: 28),
            ratingView.widthAnchor.constraint(equalToConstant:  60),
            
            favoritesButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            favoritesButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            favoritesButton.heightAnchor.constraint(equalToConstant: 32),
            favoritesButton.widthAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            authorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: 32),
            authorImageView.widthAnchor.constraint(equalToConstant: 32),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
            authorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
