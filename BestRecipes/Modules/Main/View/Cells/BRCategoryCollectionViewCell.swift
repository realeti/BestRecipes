//
//  BRCategoryCollectionViewCell.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRCategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let nameCategoryLabel: UILabel = {
        $0.text = "Salad"
        $0.textColor = .redLight.withAlphaComponent(0.5)
        $0.font = Font.getFont(.poppinsBold, size: 12)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Properties
    
    static let identifier = "BRCategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            nameCategoryLabel.textColor = self.isSelected ? .white : .redLight.withAlphaComponent(0.5)
                backgroundColor = self.isSelected ? .redBase : .white
        }
    }
    
    
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

extension BRCategoryCollectionViewCell {
    func configureCell(category name: String) {
        nameCategoryLabel.text = name
    }
}


//MARK: - Internal Methods

private extension BRCategoryCollectionViewCell {
    func configure() {
        layer.cornerRadius = 10
        
        addSubview(nameCategoryLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            nameCategoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameCategoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
