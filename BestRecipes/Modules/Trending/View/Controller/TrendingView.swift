//
//  TrendingView.swift
//  BestRecipes
//
//  Created by realeti on 13.07.2024.
//

import UIKit

final class TrendingView: UIView {
    // MARK: - UI
    lazy var trendingCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let screenWidth = ScreenSizeManager.screenWidth
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24.0
        flowLayout.estimatedItemSize = CGSize(width: screenWidth - 32, height: 180)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(TrendingViewCell.self, forCellWithReuseIdentifier: K.trendingCell)
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
        addSubview(trendingCollection)
    }
}

// MARK: - Setup Constraints
extension TrendingView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trendingCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            trendingCollection.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: trendingCollection.trailingAnchor, multiplier: 2.0),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: trendingCollection.bottomAnchor, multiplier: 1.0)
        ])
    }
}
