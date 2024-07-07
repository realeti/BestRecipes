//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

//MARK: - Presenter Protocol

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func performActionForHeader(at index: Int)
    func addToFavorites()
    func removeFromFavorites()
    func getModels() -> [SectionType]
}

enum SectionType {
    case trending(model: [TrendingModel]) // 1
    case category(model: [TrendingModel]) // 2
    case popular(model: [TrendingModel]) // 3
    case recent(model: [TrendingModel]) // 4
    case cuisine(model: [TrendingModel]) // 5
}


final class MainPresenter {
    
    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    private let router: RouterProtocol
    private let network: NetworkService
    
    private var list = BRMockData.shared.pageData
    private var sections = [SectionType]()
    
    //MARK: - Lifecycle
    
    init(network: NetworkService, router: RouterProtocol) {
        self.network = network
        self.router = router
    }
}


//MARK: - Internal Methods

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        
        
        network.fetchMainModule(BRUrlString.main) { [weak self] result in
            defer {
                group.leave()
            }
            guard let self else { return }
            switch result {
            case .success(let recipes):
            case .failure(let error):
                print(error.localizedDescription)
            }
            // configure models
            
        }
        
        group.notify(queue: .main) {
            guard let trending = newTrending,
                  let category = newCategory,
                  let popular = newPopular,
                  let cuisine = newCuisine else {
                return
            }
            configureModels()
            self.view?.render()
        }
    }
    
    
    func configureModels() {
        sections.append(.trending(model: []))
        sections.append(.category(model: []))
        sections.append(.popular(model: []))
        sections.append(.recent(model: []))
        sections.append(.cuisine(model: []))
    }
    
    func getModels() -> [SectionType] {
        sections.append(.trending(model: []))
        sections.append(.category(model: []))
        sections.append(.popular(model: []))
        sections.append(.recent(model: []))
        sections.append(.cuisine(model: []))
        return sections
    }
    
    
    func performActionForHeader(at index: Int) {
        switch index {
        case 0:
            router.showTrending()
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    
    
    func addToFavorites() {
        print("add to favorites tapped")
    }
    
    
    func removeFromFavorites() {
        print("remove to favorites tapped")
    }
}
