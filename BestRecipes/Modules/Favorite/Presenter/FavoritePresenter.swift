//
//  FavoritePresenter.swift
//  BestRecipes
//
//  Created by Руслан Алламбергенов on 07.07.2024.
//

import UIKit

//MARK: - Presenter Protocol

protocol FavoritePresenterProtocol {
    init(view: FavoriteViewProtocol, router: RouterProtocol)
    func loadRecipes ()
    func deleteRecipe(_ recipe: Recipe, recipeId: Int)
    func showRecipeDetails(for recipe: Recipe)
    var recipes: [Recipe] { get }
}


final class FavoritePresenter: FavoritePresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol
    var recipes: [Recipe] = []
    
    //MARK: - Lifecycle
    
    init(view: FavoriteViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - External Methods
    
    func loadRecipes() {
        recipes = DataManager.shared.getRecipesFrom (.favorites)
    }
    
    func deleteRecipe(_ recipe: Recipe, recipeId: Int) {
        DataManager.shared.deleteRecipe(recipe, from: .favorites)
        recipes.remove(at: recipeId)
        view?.didDeletedRecipe()
        print("recipe removed")
    }
    
    func showRecipeDetails(for recipe: Recipe) {
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
