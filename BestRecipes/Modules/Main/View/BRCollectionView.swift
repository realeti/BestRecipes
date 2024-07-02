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
    
    weak var presenterDelegate: MainPresenterProtocol?
    weak var scrollDelegate: ScrollViewDelegate?
    
    //MARK: - Lifecycle
    
    init(presenterDelegate: MainPresenterProtocol) {
        self.presenterDelegate = presenterDelegate
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        registerCells()
        registerHeaderAndFooter()
        setDelegates()
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BRCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            scrollDelegate?.collectionViewDidScrollDown(self)
        } else {
            scrollDelegate?.collectionViewDidScrollUp(self)
        }
    }
}


//MARK: - Delegate

extension BRCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        print("Ячейка в секции \(indexPath.section) и номер \(indexPath.item) была нажата.")
        
        switch indexPath.section {
        case 0:
//            presenterDelegate?.trendingCellTap()
            print(indexPath.item)
        case 1:
            print(indexPath.item)
        case 2:
            print(indexPath.item)
        case 3:
            print(indexPath.item)
        case 4:
            print(indexPath.item)
        default:
            break
        }
    }
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
