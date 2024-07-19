//
//  BRCollectionView.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRCollectionView: UICollectionView {
    
    //MARK: - Properties
    
    private var collectionLayout = UICollectionViewLayout()
    
    
    //MARK: - Models
    
    //    private(set) var sections = BRMockData.shared.pageData
    private var sections: [BRSection] = []
    
    private var categories: [BRCategoryModel] = []
    private var popular: [BRPopularModel] = []
    private var recent: [BRRecentModel] = []


    //MARK: - Dependencies
    
    weak var presenter: MainPresenterProtocol?
    
    
    //MARK: - Lifecycle
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        registerCells()
        registerHeaderAndFooter()
        setDelegates()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Delegate

extension BRCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        print("Ячейка в секции \(indexPath.section) и номер \(indexPath.item) была нажата.")
        switch indexPath.section {
        case 0:
            presenter?.performActionForSectionTrending(at: indexPath.item)
        case 1:
            presenter?.fetchPopularsByCategory(categories[indexPath.item].request)
        case 2:
            presenter?.performActionForSectionPopular(at: indexPath.item)
        case 3:
            presenter?.performActionForSectionRecent(at: indexPath.item)
        case 4:
            presenter?.performActionForSectionCuisine(at: indexPath.item)
        default:
            break
        }
    }
}


//MARK: - External Methods

extension BRCollectionView {
    func updateContent(sections: [BRSection]) {
        self.sections = sections
            reloadData()
    }
    
    
    func updateCategory(category: [BRCategoryModel]) {
        self.categories = category
            self.reloadData()
    }
    
    
    func updatePopular(popular: [BRPopularModel]) {
        DispatchQueue.main.async { [unowned self] in
            performBatchUpdates {
                sections.remove(at: 2)
                sections.insert(.popular(model: popular), at: 2)
//                deleteSections(IndexSet(integer: 2))
//                insertSections(IndexSet(integer: 2))
                reloadSections(IndexSet.init(integer: 2))
            }
        }
    }
    
    
    func updateRecent(recent: [BRRecentModel]) {
//        self.recent = recent
        
        DispatchQueue.main.async { [unowned self] in
            performBatchUpdates {
                
                self.recent = recent
                
                sections.remove(at: 3)
//                sections.insert(contentsOf: recent, at: 3)
                sections.insert(.recent(model: recent), at: 3)
            }
            reloadSections(IndexSet(integer: 3))
        }
    }
}


//MARK: - DataSource

extension BRCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .trending(let model):
            return model.count
        case .category(let model):
            return model.count
        case .popular(let model):
            return model.count
        case .recent(let model):
            return model.isEmpty ? 1 : model.count
        case .cuisine(let model):
            return model.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //MARK: - Header & Footer
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: BRSeeAllHeader.identifier, for: indexPath) as? BRSeeAllHeader else {
                return UICollectionReusableView()
            }
            
            header.tag = indexPath.section
            header.delegate = presenter
            header.configureHeader(title: sections[indexPath.section].title, section: indexPath.section)
            
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BRTrendingFooter.identifier, for: indexPath) as? BRTrendingFooter else {
                return UICollectionReusableView()
            }
            
            return footer
            
        default:
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        switch type {
            
            //MARK: - Trending Cell
            
        case .trending(model: let models):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRTrendingCollectionViewCell.identifier,
                                                 for: indexPath) as? BRTrendingCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let model = models[indexPath.row]
            cell.configure(with: model, tag: indexPath.row)
            cell.favoritesButton.delegate = presenter
            
            return cell
            
            //MARK: - Category Cell
            
        case .category(model: let models):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRCategoryCollectionViewCell.identifier,
                                                 for: indexPath) as? BRCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let model = models[indexPath.row]
            cell.configure(with: model)
            
            return cell
            
            //MARK: - Popular Cell
            
        case .popular(model: let models):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRPopularCollectionViewCell.identifier,
                                                 for: indexPath) as? BRPopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let model = models[indexPath.row]
            cell.configure(with: model)
            cell.favoritesButton.delegate = presenter
            
            return cell
            
            //MARK: - Recent Cell
            
        case .recent(model: let models):
//            if models.isEmpty {
//                guard let cell = dequeueReusableCell(withReuseIdentifier: BRRecentPlaceholderCell.identifier, for: indexPath) as? BRRecentPlaceholderCell else {
//                    return UICollectionViewCell()
//                }
//                
//                return cell
//            }
            
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRRecentCollectionViewCell.identifier,
                                                 for: indexPath) as? BRRecentCollectionViewCell else {
                return UICollectionViewCell()
            }
            //let model = models[indexPath.row]
            //cell.configure(with: model)
            return cell
            
            //MARK: - Cuisine Cell
            
        case .cuisine(model: let models):
            guard let cell = dequeueReusableCell(withReuseIdentifier: BRCuisineCollectionViewCell.identifier,
                                                 for: indexPath) as? BRCuisineCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let model = models[indexPath.row]
            cell.configure(with: model)
            
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
                                                                         heightDimension: .fractionalHeight(0.4)),
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
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(90),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(90),
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
                                                                         heightDimension: .fractionalHeight(0.45)),
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
//        if recent.isEmpty {
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .fractionalHeight(1.0))
//            
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                                                             heightDimension: .fractionalHeight(0.2)),
//                                                           subitems: [item])
//            
//            let section = createLayoutSection(group: group,
//                                              behavior: .continuous,
//                                              interGroupSpacing: 0,
//                                              supplementaryItems: [supplementaryHeaderItem()])
//            section.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 15)
//            
//            return section
//        }
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7),
                                                                         heightDimension: .fractionalHeight(0.35)),
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
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(110),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.3),
                                                                         heightDimension: .absolute(200)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 20,
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
        register(BRTrendingCollectionViewCell.self, forCellWithReuseIdentifier: BRTrendingCollectionViewCell.identifier)
        register(BRCategoryCollectionViewCell.self, forCellWithReuseIdentifier: BRCategoryCollectionViewCell.identifier)
        register(BRPopularCollectionViewCell.self, forCellWithReuseIdentifier: BRPopularCollectionViewCell.identifier)
        register(BRRecentCollectionViewCell.self, forCellWithReuseIdentifier: BRRecentCollectionViewCell.identifier)
        register(BRCuisineCollectionViewCell.self, forCellWithReuseIdentifier: BRCuisineCollectionViewCell.identifier)
        register(BRRecentPlaceholderCell.self, forCellWithReuseIdentifier: BRRecentPlaceholderCell.identifier)
    }
    
    
    func registerHeaderAndFooter() {
        register(BRSeeAllHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: BRSeeAllHeader.identifier)
        register(BRTrendingFooter.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: BRTrendingFooter.identifier)
    }
}
