//
//  SearchPresenter.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func showSearchLoading(_ loading: Bool)
    func showRecipeImageLoading(_ loading: Bool, at indexPath: IndexPath)
    func didUpdateRecipes()
    func didUpdateRecipeImage(_ imageData: Data, at: IndexPath)
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: RouterProtocol)
    var getRecipes: [Recipe] { get }
    
    func recipeSearch(with searchText: String)
    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath)
    func showRecipeDetails(for recipe: Recipe, with imageData: Data?)
    func backToHome()
}

final class SearchPresenter: SearchViewPresenterProtocol {
    // MARK: - Private Properties
    private var recipes: [Recipe] = []
    private var searchTimer: Timer?
    
    // MARK: - Public Properties
    let router: RouterProtocol
    weak var view: SearchViewProtocol?
    
    var getRecipes: [Recipe] {
        get {
            return recipes
        }
    }
    
    // MARK: - Init
    required init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Back to Home
    func backToHome() {
        router.popToRoot()
    }
    
    // MARK: - Show Recipe Details
    func showRecipeDetails(for recipe: Recipe, with imageData: Data?) {
        let recipeDetail = RecipeDetailModel(
            title: recipe.title ?? "",
            instructions: [],
            rating: recipe.rating,
            reviewsCount: recipe.reviewsCount,
            imageURL: recipe.imageURL ?? "",
            ingredients: []
        )
        router.showDetail(recipe: recipeDetail)
    }
}

// MARK: - Recipe Search
extension SearchPresenter {
    func recipeSearch(with searchText: String) {
        searchTimer?.invalidate()
        view?.showSearchLoading(true)
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.loadRecipeData(with: searchText)
        }
    }
    
    private func loadRecipeData(with searchText: String) {
        DataManager.shared.getRecepies(type: .search, by: searchText) { [weak self] result in
            self?.recipes = result
            self?.view?.showSearchLoading(false)
            self?.view?.didUpdateRecipes()
        }
    }
    
    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath) {
        view?.showRecipeImageLoading(true, at: indexPath)
        
        DataManager.shared.getImage(imageUrl) { [weak self] imageData in
            self?.view?.showRecipeImageLoading(false, at: indexPath)
            self?.view?.didUpdateRecipeImage(imageData, at: indexPath)
        }
    }
}
