//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

//MARK: - Presenter Protocol

protocol MainPresenterProtocol: AnyObject {
    func fetchData()
    func performActionForHeader(at index: Int)
    func addToFavorites(_ sender: Int)
    func removeFromFavorites(_ sender: Int)
}


final class MainPresenter {
    
    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    private let router: RouterProtocol
//    private let network: NetworkService
    private let storage = DataManager.shared
    
    
    //MARK: - Models
    
    private var sections = BRMockData.shared.pageData
//    private var sections = [BRSection]()
    
    private var trendingRecipes: [Recipe]?
    private var categoryRecipes: [Recipe]?
    private var popularRecipes: [Recipe]?
    private var recentRecipes: [Recipe]?
    private var cuisineRecipes: [Recipe]?
    
    
    //MARK: - Lifecycle
    
    init(router: RouterProtocol) {
//        self.network = network
        self.router = router
//        self.storage = storage
    }
}


//MARK: - Internal Methods

extension MainPresenter: MainPresenterProtocol {
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        storage.getRecepies(type: .trend, by: "", offset: 0 ) { recipes in
            defer {
                group.leave()
            }
            self.trendingRecipes = recipes
        }
        
        group.enter()
        storage.getRecepies(type: .type, by: MealTypes.getRandom().rawValue, offset: 0) { recipes in
            defer {
                group.leave()
            }
            self.categoryRecipes = recipes
        }
        
        group.enter()
        storage.getRecepies(type: .cuisine, by: CuisineType.getRandom().rawValue, offset: 0) { recipes in
            defer {
                group.leave()
            }
            self.cuisineRecipes = recipes
        }
        
        group.notify(queue: .main) {
            guard let trending = self.trendingRecipes,
                  let category = self.categoryRecipes,
                  let cuisine = self.cuisineRecipes else {
                return
            }
            self.configureModels(
                trending: trending,
                category: category,
                cuisine: cuisine
            )
        }
    }
    
    
    func configureModels(trending: [Recipe], category: [Recipe], cuisine: [Recipe]) {
        sections.append(.trending(model: trending.map({ recipe in
            return BRTrendingModel(recipe)
        })))
        sections.append(.category(model: category.map({ recipe in
            return BRCategoryModel(recipe)
        })))
        sections.append(.cuisine(model: cuisine.map({ recipe in
            return BRCuisineModel(recipe)
        })))
        
        self.view?.render(sections: sections)
    }
    
    
    func performActionForHeader(at index: Int) {
        switch index {
        case 0:
            print(index)
            router.showTrending()
        case 3:
            print(index)
        case 4:
            print(index)
        default:
            break
        }
    }
    
    
    func addToFavorites(_ sender: Int) {
        storage.addRecipe(trendingRecipes[sender], to: SavedRecipesType.Type)
        print("add to favorites tapped")
    }
    
    
    func removeFromFavorites(_ sender: Int) {
        print("remove to favorites tapped")
    }
}
