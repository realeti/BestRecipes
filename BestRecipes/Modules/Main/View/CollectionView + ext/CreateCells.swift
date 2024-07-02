//
//  CreateLayout.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import UIKit

//MARK: - DataSource

extension BRCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //MARK: - Header & Footer
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: BRSeeAllHeader.idHeader, for: indexPath) as? BRSeeAllHeader else {
                return UICollectionReusableView()
            }
            
            header.tag = indexPath.section
            header.delegate = headerDelegate
            header.configureHeader(title: sections[indexPath.section].title, section: indexPath.section)
            
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BRTrendingFooter.idFooter, for: indexPath) as? BRTrendingFooter else {
                return UICollectionReusableView()
            }
            
            return footer
            
        default:
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
            //MARK: - Trending Cell
            
        case .trending(let trending):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRTrendingCollectionViewCell.idCell,
                                                 for: indexPath) as? BRTrendingCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(rating: trending[indexPath.item].rating,
                               image: trending[indexPath.item].image!,
                               title: trending[indexPath.item].title,
                               authorImage: trending[indexPath.item].authorImage!,
                               author: trending[indexPath.item].author)
            
            return cell
            
            //MARK: - Category Cell
            
        case .category(let category):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRCategoryCollectionViewCell.idCell,
                                                 for: indexPath) as? BRCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(category: category[indexPath.row].title)
            
            return cell
            
            //MARK: - Popular Cell
            
        case .popular(let popular):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRPopularCollectionViewCell.idCell,
                                                 for: indexPath) as? BRPopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: popular[indexPath.row].image!,
                               title: popular[indexPath.row].title,
                               time: popular[indexPath.row].timeRemaining)
            
            return cell
            
            //MARK: - Recent Cell
            
        case .recent(let recent):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRRecentCollectionViewCell.idCell,
                                                 for: indexPath) as? BRRecentCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: recent[indexPath.row].image!,
                               title: recent[indexPath.row].title,
                               authorName: recent[indexPath.row].author)
            
            return cell
            
            //MARK: - Cuisine Cell
            
        case .cuisine(let cuisine):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRCuisineCollectionViewCell.idCell,
                                                 for: indexPath) as? BRCuisineCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: cuisine[indexPath.row].image!,
                               title: cuisine[indexPath.row].title)
            
            return cell
        }
    }
}
