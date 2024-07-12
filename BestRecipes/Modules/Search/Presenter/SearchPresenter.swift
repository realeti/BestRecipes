//
//  SearchPresenter.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func showLoading(_ loading: Bool)
    func didUpdateRecipes()
    func didUpdateRecipeImage(_ imageData: Data, at: IndexPath)
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: RouterProtocol)
    var getRecipes: [Recipe] { get }
    
    func recipeSearch(with searchText: String)
    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath)
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
}

// MARK: - Recipe Search
extension SearchPresenter {
    func recipeSearch(with searchText: String) {
        searchTimer?.invalidate()
        view?.showLoading(true)
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.loadRecipeData(with: searchText)
        }
    }
    
    private func loadRecipeData(with searchText: String) {
        DataManager.shared.getRecepies(type: .search, by: searchText) { [weak self] result in
            self?.recipes = result
            self?.view?.showLoading(false)
            self?.view?.didUpdateRecipes()
        }
    }
    
    func loadRecipeImage(with imageUrl: String, at indexPath: IndexPath) {
        DataManager.shared.getImage(imageUrl) { [weak self] imageData in
            self?.view?.didUpdateRecipeImage(imageData, at: indexPath)
        }
    }
}
