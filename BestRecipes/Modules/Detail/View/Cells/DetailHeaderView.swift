//
//  DetailHeaderView.swift
//  BestRecipes
//
//  Created by realeti on 16.07.2024.
//

import UIKit

final class DetailHeaderView: UITableViewHeaderFooterView {
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
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.addSubview(titleStack)
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
            titleStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
    }
}
