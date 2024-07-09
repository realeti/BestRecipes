//
//  BRTrendingFooter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRTrendingFooter: UICollectionReusableView {
    
    //MARK: - UI
    
    private let titleLabel: UILabel = {
        $0.text = "Popular Category"
        $0.textColor = .blackBase
        $0.textAlignment = .left
        $0.font = Font.getFont(.poppinsBold, size: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Properties
    
    static let identifier = "BRTrendingFooter"
    
    
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

private extension BRTrendingFooter {
    func configure() {
        backgroundColor = .none
        addSubviews(titleLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
