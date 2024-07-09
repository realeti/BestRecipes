//
//  SearchView.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

final class SearchView: UIView {
    // MARK: - UI
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.redBase.cgColor
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /*private lazy var searchIcon: UIImageView = {
        let view = UIImageView(image: .search)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()*/
    
    private lazy var searchIcon: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(resource: .search).withRenderingMode(.alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        let textFieldFont = Font.getFont(.poppinsRegular, size: 14.0)
        textField.backgroundColor = .clear
        textField.textColor = .blackBase
        textField.tintColor = .blackBase
        textField.font = textFieldFont
        let attributes = [NSAttributedString.Key.font: textFieldFont]
        let attributedPlaceholder = NSAttributedString(string: K.searchPlaceholer, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var searchCancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.plus, for: .normal)
        button.transform = CGAffineTransform(rotationAngle: .pi / 4)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(searchStackView)
        searchStackView.addArrangedSubview(searchIcon)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchCancelButton)
    }
}

// MARK: - Setup Constraints
extension SearchView {
    private func setupConstraints() {
        setupSearchStackConstraints()
        setupSearchIconsConstraints()
    }
    
    private func setupSearchStackConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            searchStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 3.0)
        ])
    }
    
    private func setupSearchIconsConstraints() {
        NSLayoutConstraint.activate([
            searchIcon.heightAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            searchIcon.widthAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            
            searchCancelButton.heightAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            searchCancelButton.widthAnchor.constraint(equalToConstant: Metrics.searchIconSize)
        ])
    }
}

fileprivate struct Metrics {
    static let searchIconSize: CGFloat = 20.0
}
