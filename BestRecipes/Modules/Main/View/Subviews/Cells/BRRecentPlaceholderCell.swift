//
//  BRRecentPlaceholderCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 11.07.2024.
//

import UIKit

final class BRRecentPlaceholderCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let backgroundCellView: UIView = {
        $0.backgroundColor = .greyLighter
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.text = "You haven't looked at any recipes yet"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    
    //MARK: - Properties
    
    static let identifier = "BRPlaceholderCell"
    
    
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


//MARK: - Internal Methods

private extension BRRecentPlaceholderCell {
    func configure() {
        addSubviews(backgroundCellView, titleLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor),
            backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundCellView.centerYAnchor),
        ])
    }
}
