//
//  DetailHeaderView.swift
//  BestRecipes
//
//  Created by realeti on 16.07.2024.
//

import UIKit

final class DetailHeaderView: UIView {
    // MARK: - UI
    private let titleStack = UIStackView(
        axis: .horizontal,
        spacing: 0,
        distribution: .fill
    )
    
    private let titleLabel = UILabel(
        text: K.ingredients,
        color: .black,
        font: .poppinsBold,
        fontSize: 20.0
    )
    
    private let itemsLabel = UILabel(
        color: .greyBase,
        font: .poppinsRegular,
        fontSize: 14.0
    )
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(titleStack)
        titleStack.addArrangedSubviews(titleLabel, itemsLabel)
    }
}

// MARK: - Configure
extension DetailHeaderView {
    func configure(itemsCount: Int) {
        itemsLabel.text = "\(itemsCount) items"
    }
}

// MARK: - Setup Constraints
extension DetailHeaderView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
