//
//  TrendingPresenter.swift
//  BestRecipes
//
//  Created by realeti on 13.07.2024.
//

import Foundation

protocol TrendingViewProtocol: AnyObject {
    func showRecipeImageLoading(_ loading: Bool, at indexPath: IndexPath)
    func didUpdateRecipeImage(_ imageData: Data, at: IndexPath)
}

protocol TrendingPresenterProtocol {
    init(view: TrendingViewProtocol, router: RouterProtocol, recipes: [Recipe])
    var getRecipes: [Recipe] { get }

    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath)
    func showRecipeDetails(for recipe: Recipe, with imageData: Data?)
    func saveRecipe(recipe: Recipe, imageData: Data)
    func deleteRecipe(recipe: Recipe)
    func toggleSaveState(at recipeId: Int)
    func isRecipeSaved(at recipeId: Int) -> Bool
}

final class TrendingPresenter: TrendingPresenterProtocol {
    // MARK: - Private Properties
    private var recipes: [Recipe] = []
    private var savedRecipes: [Bool] = []
    
    // MARK: - Public Properties
    let router: RouterProtocol
    weak var view: TrendingViewProtocol?
    
    var getRecipes: [Recipe] {
        get {
            return recipes
        }
    }
    
    //MARK: - Init
    init(view: TrendingViewProtocol, router: RouterProtocol, recipes: [Recipe]) {
        self.view = view
        self.router = router
        self.recipes = recipes
        savedRecipes = Array(repeating: false, count: recipes.count)
    }
    
    // MARK: - Show Recipe Details
    func showRecipeDetails(for recipe: Recipe, with imageData: Data?) {
        let recipeDetail = RecipeDetailModel(
            title: recipe.title ?? "",
            instruction: recipe.mockInstuction,
            rating: recipe.rating,
            reviewsCount: recipe.reviewsCount,
            imageURL: recipe.imageURL ?? "",
            ingredients: []
        )
        router.showDetail(recipe: recipeDetail)
    }
    
    func toggleSaveState(at recipeId: Int) {
        savedRecipes[recipeId].toggle()
    }
    
    func isRecipeSaved(at recipeId: Int) -> Bool {
        return savedRecipes[recipeId]
    }
}

// MARK: - Save & Delete Recipe
extension TrendingPresenter {
    func saveRecipe(recipe: Recipe, imageData: Data) {
        DataManager.shared.addRecipe(recipe, to: .favorites)
        print("recipe saved")
    }
    
    func deleteRecipe(recipe: Recipe) {
        DataManager.shared.deleteRecipe(recipe, from: .favorites)
        print("recipe deleted")
    }
}

// MARK: - Load Recipe Image
extension TrendingPresenter {
    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath) {
        view?.showRecipeImageLoading(true, at: indexPath)
        
        DataManager.shared.getImage(imageUrl) { [weak self] imageData in
            self?.view?.showRecipeImageLoading(false, at: indexPath)
            self?.view?.didUpdateRecipeImage(imageData, at: indexPath)
        }
    }
}
