//
//  SearchView.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

final class SearchView: UIView {
    // MARK: - UI
    lazy var recipeCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: K.searchHeaderView)
        collectionView.register(MyRecipesCollectionCell.self, forCellWithReuseIdentifier: K.myRecipesCell)
        collectionView.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: K.emptyCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        backgroundColor = .white
        addSubview(recipeCollection)
    }
}

// MARK: - Setup Constraints
extension SearchView {
    private func setupConstraints() {
        setupRecipeCollectionConstraints()
    }
    
    private func setupRecipeCollectionConstraints() {
        NSLayoutConstraint.activate([
            recipeCollection.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            recipeCollection.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: recipeCollection.trailingAnchor, multiplier: 2.0),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: recipeCollection.bottomAnchor, multiplier: 1.0)
        ])
    }
}
