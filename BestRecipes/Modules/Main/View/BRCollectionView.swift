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
    private(set) var sections = BRMockData.shared.pageData
    
    weak var presenterDelegate: MainPresenterProtocol?
    
    private let categoryesNamesData: [BRCategoryName] = [
        .init(categoryName: "Main course", nameForRequest: "main%20course", isSelected: true),
        .init(categoryName: "Side dish", nameForRequest: "side%20dish"),
        .init(categoryName: "Dessert", nameForRequest: "dessert"),
        .init(categoryName: "Appetizer", nameForRequest: "appetizer"),
        .init(categoryName: "Salad", nameForRequest: "salad"),
        .init(categoryName: "Bread", nameForRequest: "bread"),
        .init(categoryName: "Breakfast", nameForRequest: "breakfast"),
        .init(categoryName: "Soup", nameForRequest: "soup"),
        .init(categoryName: "Beverage", nameForRequest: "beverage"),
        .init(categoryName: "Sauce", nameForRequest: "sauce"),
        .init(categoryName: "Marinade", nameForRequest: "marinade"),
        .init(categoryName: "Finger food", nameForRequest: "fingerfood"),
        .init(categoryName: "Snack", nameForRequest: "snack"),
        .init(categoryName: "Drink", nameForRequest: "drink")
    ]
    
    
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
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension BRCollectionView {
    func updateContent(_ sections: [BRListSection]) {
        self.sections = sections
        reloadData()
    }
//    
//    func reloadCollectionView(section: Int) {
//        let indexSet = IndexSet(integer: section)
//        reloadSections(indexSet)
//    }
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
            header.delegate = presenterDelegate
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
                               image: trending[indexPath.item].image ?? .media,
                               title: trending[indexPath.item].title,
                               authorImage: trending[indexPath.item].authorImage ?? .avatar3,
                               author: trending[indexPath.item].author,
                               index: indexPath)

            cell.favoritesButton.delegate = presenterDelegate
            
            
            return cell
            
            //MARK: - Category Cell
            
        case .category:
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRCategoryCollectionViewCell.idCell,
                                                 for: indexPath) as? BRCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let currentCategory = categoryesNamesData[indexPath.row].categoryName
            cell.configureCell(category: currentCategory)
            
            return cell
            
            //MARK: - Popular Cell
            
        case .popular(let popular):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRPopularCollectionViewCell.idCell,
                                                 for: indexPath) as? BRPopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: popular[indexPath.row].image ?? .media2,
                               title: popular[indexPath.row].title,
                               time: popular[indexPath.row].timeRemaining)
            
            cell.favoritesButton.delegate = presenterDelegate
            
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
            
            cell.configureCell(image: cuisine[indexPath.row].image ?? .avatar,
                               title: cuisine[indexPath.row].title)
            
            return cell
        }
    }
}


//MARK: - Internal Methods

private extension BRCollectionView {
    
    //MARK: - Create Layout
    
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
    
    
    //MARK: - Setup UI
    
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
