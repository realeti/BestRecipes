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
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: RouterProtocol)
    var recipes: [Recipe] { get }
    
    func recipeSearch(with searchText: String)
    func backToHome()
}

final class SearchPresenter: SearchViewPresenterProtocol {
    // MARK: - Private Properties
    private var searchTimer: Timer?
    
    // MARK: - Public Properties
    let router: RouterProtocol
    var recipes: [Recipe] = []
    weak var view: SearchViewProtocol?
    
    // MARK: - Init
    required init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Back to Home
    func backToHome() {
        router.popToRoot()
    }
    
    // MARK: - Get array of recipes
    func getFoundRecipes() -> [Recipe] {
        return []
    }
}

// MARK: - Recipe Search
extension SearchPresenter {
    func recipeSearch(with searchText: String) {
        searchTimer?.invalidate()
        view?.showLoading(true)
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { [weak self] _ in
            self?.getRecipe(with: searchText)
        }
    }
    
    private func getRecipe(with searchText: String) {
        DataManager.shared.getRecepies(type: .search, by: searchText) { [weak self] result in
            self?.recipes = result
            self?.view?.showLoading(false)
            self?.view?.didUpdateRecipes()
        }
    }
}
