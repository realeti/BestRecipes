//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

//MARK: - Presenter Protocol

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
    
    func searchTextFieldTap()
//    func trendingButtonDidTap()
//    func recentRecipeButtonDidTap()
//    func cuisineButtonDidTap()
}


final class MainPresenter: MainPresenterProtocol {

    //MARK: - Properties
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    
    
    //MARK: - Lifecycle
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
    //MARK: - External Methods
    
    func searchTextFieldTap() {
        print("router show trending")
        router?.showTrending()
    }
}
