//
//  EmptySearchViewCell.swift
//  BestRecipes
//
//  Created by realeti on 12.07.2024.
//

import UIKit

final class EmptySearchViewCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyLight
        label.textAlignment = .center
        label.font = Font.getFont(.poppinsRegular, size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        contentView.addSubview(textLabel)
    }
}

// MARK: - Configure Cell
extension EmptySearchViewCell {
    func configure(with text: String) {
        textLabel.text = text
    }
}

// MARK: - Setup Constraints
extension EmptySearchViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 3.0),
            textLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: textLabel.trailingAnchor, multiplier: 1.0),
            bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: textLabel.bottomAnchor, multiplier: 1.0)
        ])
    }
}
