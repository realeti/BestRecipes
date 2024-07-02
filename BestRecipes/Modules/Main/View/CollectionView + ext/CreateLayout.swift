//
//  CreateLayout.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

//MARK: - Create Layout

extension BRCollectionView {
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = sections[sectionIndex]
            switch section {
            case .trending:
                return createTrendingSection()
            case .category:
                return createCategorySection()
            case .popular:
                return createPopularSection()
            case .recent:
                return createRecentSection()
            case .cuisine:
                return createCuisineSection()
            }
        }
    }
    

    //MARK: - Configure Sections
    
    func createLayoutSection(group: NSCollectionLayoutGroup,
                             behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                             interGroupSpacing: CGFloat,
                             supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = false
        return section
    }
    
    
    //MARK: - Header
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(20)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
    
    //MARK: - Footer
    
    func supplementaryFooterItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(20)),
              elementKind: UICollectionView.elementKindSectionFooter,
              alignment: .bottom,
              absoluteOffset: CGPoint(x: 0, y: 25))
    }
    
    
    //MARK: - Trending Section
    
    func createTrendingSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75),
                                                                         heightDimension: .fractionalHeight(0.35)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 20,
                                          supplementaryItems: [supplementaryHeaderItem(), supplementaryFooterItem()])
        section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 10)
        section.supplementariesFollowContentInsets = false
        return section
    }
    
    
    //MARK: - Category Section
    
    func createCategorySection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4),
                                                                         heightDimension: .fractionalHeight(0.05)),
                                                       subitems: [item])
        group.interItemSpacing = .fixed(5)
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [])
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 10)
        return section
    }
    
    
    //MARK: - Popular Section
    
    func createPopularSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.38),
                                                                         heightDimension: .fractionalHeight(0.4)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [])
        section.contentInsets = .init(top: 15, leading: 15, bottom: 10, trailing: 10)
        return section
    }


    //MARK: - Recent Section
    
    func createRecentSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7),
                                                                         heightDimension: .fractionalHeight(0.32)),
                                                       subitems: [item])
        group.interItemSpacing = .fixed(15)
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 15,
                                          supplementaryItems: [supplementaryHeaderItem()])
        section.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 10)
        return section
    }
    
    
    //MARK: - Cuisine Section
    
    func createCuisineSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.3)),
                                                       subitems: [item])
        group.interItemSpacing = .fixed(15)
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 15,
                                          supplementaryItems: [supplementaryHeaderItem()])
        section.contentInsets = .init(top: 10, leading: 15, bottom: 0, trailing: 10)
        return section
    }
}
