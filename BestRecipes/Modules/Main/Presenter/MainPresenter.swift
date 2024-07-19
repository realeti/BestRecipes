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
    func fetchPopularsByCategory(_ mealType: String)
    func performActionForHeader(at index: Int)
    func performActionForSectionTrending(at index: Int)
    func performActionForSectionPopular(at index: Int)
    func performActionForSectionRecent(at index: Int)
    func performActionForSectionCuisine(at index: Int)
    func addToFavorites(_ sender: Int)
    func removeFromFavorites(_ sender: Int)
    func addRecent()
    func showSearch()
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
        
    
    private var recent: [BRRecentModel] = DataManager.shared.getRecipesFrom(.recent).map { recipe in
        BRRecentModel(recipe)
    }
    
    
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
        storage.getRecepies(type: .type, by: "main%20course") { recipes in
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
    
    
    func fetchPopularsByCategory(_ mealType: String) {
        storage.getRecepies(type: .type, by: mealType) { recipes in
            self.popularRecipes = recipes
            self.view?.setPopularByCategory(self.popularRecipes.map({ recipe in
                return BRPopularModel(recipe)
            }))
        }
    }
    
    func addToFavorites(_ sender: Int) {
        print("add to favorites tapped \(sender)")
        storage.addRecipe(trendingRecipes[sender], to: .favorites)
    }
    
    
    func removeFromFavorites(_ sender: Int) {
        print("remove to favorites tapped \(sender)")
        storage.deleteRecipe(trendingRecipes[sender], from: .favorites)
    }
    
    
    func addRecent() {
        self.recentRecipes = storage.getRecipesFrom(.recent)
        self.view?.addRecentRecipe(recentRecipes.map({ recipe in
            return BRRecentModel(recipe)
        }))
    }
    
    func showSearch() {
        router.showSearch()
    }
}

// MARK: - Perform Actions
extension MainPresenter {
    func performActionForHeader(at index: Int) {
        switch index {
        case 0:
            print("trending #\(index)")
            router.showTrending(title: K.trendingTitle, recipes: trendingRecipes)
        case 3:
            print("recent #\(index)")
            router.showTrending(title: K.recentRecipesTitle, recipes: recentRecipes)
        case 4:
            print("popular cuisine #\(index)")
            router.showTrending(title: K.popularCuisineTitle, recipes: cuisineRecipes)
        default:
            break
        }
    }
    
    func performActionForSectionTrending(at index: Int) {
        guard !trendingRecipes.isEmpty else {
            return
        }
        
        let recipe = trendingRecipes[index]
        showDetail(with: recipe)
    }
    
    func performActionForSectionPopular(at index: Int) {
        guard !popularRecipes.isEmpty else {
            return
        }
        
        let recipe = popularRecipes[index]
        showDetail(with: recipe)
    }
    
    func performActionForSectionRecent(at index: Int) {
        guard !recentRecipes.isEmpty else {
            return
        }
        
        let recipe = recentRecipes[index]
        showDetail(with: recipe)
    }
    
    func performActionForSectionCuisine(at index: Int) {
        guard !cuisineRecipes.isEmpty else {
            return
        }
        
        let recipe = cuisineRecipes[index]
        showDetail(with: recipe)
    }
    
    private func showDetail(with recipe: Recipe) {
        var detailIngredients: [DetailIngredient] = []
        
        if let ingredients = recipe.extendedIngredients {
            detailIngredients = ingredients.map {
                DetailIngredient(from: $0)
            }
        }
        
        let recipeDetail = RecipeDetailModel(
            title: recipe.title ?? "",
            instruction: recipe.mockInstuction,
            rating: recipe.rating,
            reviewsCount: recipe.reviewsCount,
            imageURL: recipe.imageURL ?? "",
            ingredients: detailIngredients
        )
        router.showDetail(recipe: recipeDetail)
    }
}
