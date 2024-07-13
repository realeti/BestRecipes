//
//  BRCuisineCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRCuisineCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let cuisineImageView: UIImageView = {
        $0.image = .avatar
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "Ify's Kitchen"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 12)
        $0.numberOfLines = 3
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Properties
    
    static let identifier = "BRCuisineCollectionViewCell"
    
    
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

extension BRCuisineCollectionViewCell {
    func configure(with model: BRCuisineModel) {
        titleLabel.text = model.title
        
//        cuisineImageView.image = UIImage(named: model.imageURL ?? "media")
        DataManager.shared.getImage(model.imageURL ?? "media") { [weak self] imageData in
            DispatchQueue.main.async {
                self?.cuisineImageView.image = UIImage(data: imageData)
            }
        }
        
        
    }
}


//MARK: - Internal Methods

private extension BRCuisineCollectionViewCell {
    
    //MARK: - Setup UI
    
    func configure() {
        addSubviews(cuisineImageView, titleLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            cuisineImageView.topAnchor.constraint(equalTo: topAnchor),
            cuisineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cuisineImageView.heightAnchor.constraint(equalToConstant: 130),
            cuisineImageView.widthAnchor.constraint(equalToConstant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: cuisineImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
