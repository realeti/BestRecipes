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
    var recipes: [Recipe] { get }
}


final class FavoritePresenter: FavoritePresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: FavoriteViewProtocol?
    var router: RouterProtocol?
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
}
