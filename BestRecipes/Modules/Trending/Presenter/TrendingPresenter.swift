//
//  TrendingPresenter.swift
//  BestRecipes
//
//  Created by realeti on 13.07.2024.
//

import Foundation

protocol TrendingViewProtocol: AnyObject {
    func updateRecipes()
}

protocol TrendingPresenterProtocol {
    init(view: TrendingViewProtocol, router: RouterProtocol)
    var getRecipes: [Recipe] { get }

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
    init(view: TrendingViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        
        savedRecipes = Array(repeating: false, count: 12)
    }
    
    // MARK: - Show Recipe Details
    func showRecipeDetails(for recipe: Recipe, with imageData: Data?) {
        //router.showDetail(for: recipe, with: imageData)
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
