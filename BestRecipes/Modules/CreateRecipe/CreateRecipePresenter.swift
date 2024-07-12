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
    init(vc: CreateRecipeViewControllerProtocol, router: RouterProtocol)
    func createRecipe()
    func goBack()
}

final class CreateRecipePresenter: CreateRecipePresenterProtocol {
    private unowned let vc: CreateRecipeViewControllerProtocol
    private let router: RouterProtocol
    
    init(vc: CreateRecipeViewControllerProtocol, router: RouterProtocol) {
        self.vc = vc
        self.router = router
    }
    
    func createRecipe() {
        print(#function)
        print("bitton Taped")
    }
    
    func goBack() {
        router.popToPrevious()
    }
}
