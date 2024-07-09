//
//  SearchView.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

final class SearchView: UIView {
    // MARK: - UI
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 8)
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.redBase.cgColor
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(resource: .search).withRenderingMode(.alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchTextField: UITextField = {
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
    
    lazy var searchCancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.plus, for: .normal)
        button.transform = CGAffineTransform(rotationAngle: .pi / 4)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var recipeCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.description())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        //addSubview(containerView)
        //containerView.addSubviews(searchStackView, recipeCollection)
        addSubviews(searchStackView, recipeCollection)
        searchStackView.addArrangedSubviews(searchButton, searchTextField, searchCancelButton)
    }
}

// MARK: - Setup Constraints
extension SearchView {
    private func setupConstraints() {
        //setupContainerViewConstraints()
        setupSearchStackConstraints()
        setupSearchIconsConstraints()
        setupRecipeCollectionConstraints()
    }
    
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            containerView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: containerView.trailingAnchor, multiplier: 3.0)
        ])
    }
    
    private func setupSearchStackConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            searchStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 3.0)
        ])
        /*NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            searchStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])*/
    }
    
    private func setupSearchIconsConstraints() {
        NSLayoutConstraint.activate([
            searchButton.heightAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            searchButton.widthAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            searchCancelButton.heightAnchor.constraint(equalToConstant: Metrics.searchIconSize),
            searchCancelButton.widthAnchor.constraint(equalToConstant: Metrics.searchIconSize)
        ])
    }
    
    private func setupRecipeCollectionConstraints() {
        NSLayoutConstraint.activate([
            recipeCollection.topAnchor.constraint(equalToSystemSpacingBelow: searchStackView.bottomAnchor, multiplier: 2.0),
            recipeCollection.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: recipeCollection.trailingAnchor, multiplier: 2.0),
            recipeCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24.0)
        ])
    }
}

fileprivate struct Metrics {
    static let searchIconSize: CGFloat = 20.0
}
