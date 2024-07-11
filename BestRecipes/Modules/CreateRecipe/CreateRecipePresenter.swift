//
//  CreateRecipePresenter.swift
//  BestRecipes
//
//  Created by nik on 09.07.24.
//

import Foundation

//protocol CreateRecipeViewProtocol: AnyObject {
//    func createRecipe()
//}

protocol CreateRecipePresenterProtocol: AnyObject {
    init(vc: CreateRecipeViewControllerProtocol, router: CreateRecipeRouterProtocol)
    func createRecipe()
    func goBack()
}

final class CreateRecipePresenter: CreateRecipePresenterProtocol {
    private unowned let vc: CreateRecipeViewControllerProtocol
    private let router: CreateRecipeRouterProtocol
    
    init(vc: CreateRecipeViewControllerProtocol, router: CreateRecipeRouterProtocol) {
        self.vc = vc
        self.router = router
    }
    
    func createRecipe() {
        print(#function)
        print("bitton Taped")
    }
    
    func goBack() {
        router.goBack()
    }
}
