//
//  BRRatingView.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRRatingView: UIView {
    
    private let starImageView: UIImageView = {
        $0.image = .star
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    public let rateLabel: UILabel = {
        $0.text = "4,5"
        $0.textColor = .white
        $0.font = Font.getFont(.poppinsBold, size: 14)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        setupViews()
        setCostraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension BRRatingView {
    func configure() {
        backgroundColor = .greyBase.withAlphaComponent(0.75)
        layer.cornerRadius = 7
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupViews() {
        addSubviews(starImageView, rateLabel)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            starImageView.heightAnchor.constraint(equalToConstant: 18),
            starImageView.widthAnchor.constraint(equalToConstant: 18),
            
            rateLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7)
        ])
    }
}
