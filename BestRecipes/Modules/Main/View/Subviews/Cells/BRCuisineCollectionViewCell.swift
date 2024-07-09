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
        $0.layer.cornerRadius = 55
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "Ify's Kitchen"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 12)
        $0.numberOfLines = 1
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
        cuisineImageView.image = UIImage(named: model.imageURL ?? "media2")
        titleLabel.text = model.title
    }
}


//MARK: - Internal Methods

private extension BRCuisineCollectionViewCell {
    func configure() {
        addSubviews(cuisineImageView, titleLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            cuisineImageView.topAnchor.constraint(equalTo: topAnchor),
            cuisineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cuisineImageView.heightAnchor.constraint(equalToConstant: 110),
            cuisineImageView.widthAnchor.constraint(equalToConstant: 110),
            
            titleLabel.centerXAnchor.constraint(equalTo: cuisineImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: cuisineImageView.bottomAnchor, constant: 10),
        ])
    }
}
