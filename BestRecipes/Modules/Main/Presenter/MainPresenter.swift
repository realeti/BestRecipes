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
    
    //MARK: - Dependencies
    
    weak var view: MainViewProtocol?
    private let router: RouterProtocol
    private let storage = DataManager.shared
    
    
    //MARK: - Models
    
//    private var sections = BRMockData.shared.pageData
        private var sections = [BRSection]()
    
    private var trendingRecipes: [Recipe] = []
    private var popularRecipes: [Recipe] = []
    private var recentRecipes: [Recipe] = []
    private var cuisineRecipes: [Recipe] = []
    
    private var categories: [BRCategoryModel] = [
        .init(type: "Main course", request: "main%20course"),
        .init(type: "Side dish", request: "side%20dish"),
        .init(type: "Dessert", request: "dessert"),
        .init(type: "Appetizer", request: "appetizer"),
        .init(type: "Salad", request: "salad"),
        .init(type: "Bread", request: "bread"),
        .init(type: "Breakfast", request: "breakfast"),
        .init(type: "Soup", request: "soup"),
        .init(type: "Beverage", request: "beverage"),
        .init(type: "Sauce", request: "sauce"),
        .init(type: "Marinade", request: "marinade"),
        .init(type: "Finger food", request: "fingerfood"),
        .init(type: "Snack", request: "snack"),
        .init(type: "Drink", request: "drink")
    ]
    
    private let authors: [BRAuthorsModel] = [
        .init(authorImageName: "Foodista"),
        .init(authorImageName: "foodista.com"),
        .init(authorImageName: "Afrolems"),
        .init(authorImageName: "Full Belly Sisters"),
        .init(authorImageName: "Pink When"),
        .init(authorImageName: "blogspot.com"),
        .init(authorImageName: "Food and Spice"),
        .init(authorImageName: "pinkwhen.com")
    ]
        
    
    private var recent: [BRRecentModel] = []
    
    
    //MARK: - Lifecycle
    
    init(router: RouterProtocol) {
        self.router = router
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
        storage.getRecepies(type: .tags, by: "main%20course") { recipes in
            defer {
                group.leave()
            }
            self.popularRecipes = recipes
        }
        
        group.enter()
        storage.getRecepies(type: .cuisine, by: CuisineType.getRandom().rawValue, offset: 0) { recipes in
            defer {
                group.leave()
            }
            self.cuisineRecipes = recipes
        }
        
        group.notify(queue: .main) {
            self.configureModels(
                trending: self.trendingRecipes,
                popular: self.popularRecipes,
                cuisine: self.cuisineRecipes
            )
        }
    }
    
    
    func configureModels(trending: [Recipe], popular: [Recipe], cuisine: [Recipe]) {
        sections.append(.trending(model: trending.map({ recipe in
            var trendingModel = BRTrendingModel(recipe)
            trendingModel.authorImage = recipe.author ?? "emptyAvatar"
            return trendingModel
        })))
        sections.append(.category(model: categories))
        sections.append(.popular(model: popular.map({ recipe in
            return BRPopularModel(recipe)
        })))
        sections.append(.recent(model: recent))
        sections.append(.cuisine(model: cuisine.map({ recipe in
            return BRCuisineModel(recipe)
        })))
        
        self.view?.render(sections: sections)
        self.view?.addCategories(category: categories)
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
        print("add to favorites tapped \(sender)")
        storage.addRecipe(trendingRecipes[sender], to: SavedRecipesType.favorites)
    }
    
    
    func removeFromFavorites(_ sender: Int) {
        print("remove to favorites tapped \(sender)")
    }
}
