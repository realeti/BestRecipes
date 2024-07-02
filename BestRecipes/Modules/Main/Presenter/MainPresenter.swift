//
//  MainPresenter.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 02.07.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func searchTextFieldTap()
//    func trendingButtonDidTap()
//    func recentRecipeButtonDidTap()
//    func cuisineButtonDidTap()
}


final class MainPresenter: MainPresenterProtocol {
    func searchTextFieldTap() {
        print("search did tap presenter")
    }
    
    
    weak var view: MainViewPresenterProtocol?
    
}
