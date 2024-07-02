//
//  BRCollectionView.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRCollectionView: UICollectionView {
    
    //MARK: - Properties
    
    private let collectionLayout = UICollectionViewLayout()
    public let sections = BRMockData.shared.pageData
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        registerCells()
        registerHeaderAndFooter()
        setDelegates()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Delegate

extension BRCollectionView: UICollectionViewDelegate {
    
}


//MARK: - Internal Methods

private extension BRCollectionView {
    func configure() {
        collectionViewLayout = createLayout()
        backgroundColor = .none
        bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setDelegates() {
        delegate = self
        dataSource = self
    }
    
    
    func registerCells() {
        register(BRTrendingCollectionViewCell.self, forCellWithReuseIdentifier: BRTrendingCollectionViewCell.idCell)
        register(BRCategoryCollectionViewCell.self, forCellWithReuseIdentifier: BRCategoryCollectionViewCell.idCell)
        register(BRPopularCollectionViewCell.self, forCellWithReuseIdentifier: BRPopularCollectionViewCell.idCell)
        register(BRRecentCollectionViewCell.self, forCellWithReuseIdentifier: BRRecentCollectionViewCell.idCell)
        register(BRCuisineCollectionViewCell.self, forCellWithReuseIdentifier: BRCuisineCollectionViewCell.idCell)
    }
    
    
    func registerHeaderAndFooter() {
        register(BRSeeAllHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: BRSeeAllHeader.idHeader)
        register(BRTrendingFooter.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: BRTrendingFooter.idFooter)
    }
}
