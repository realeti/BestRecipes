//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by nik on 10.07.24.
//

import UIKit

protocol CreateRecipeViewControllerProtocol: AnyObject {
    func sayHi()
}

final class CreateRecipeViewController: UIViewController {
    var presenter: CreateRecipePresenterProtocol?
    
    private let createRecipeView = CreateRecipeView()
        
    override func loadView() {
        view = createRecipeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRecipeView.delegate = self
        
        view.backgroundColor = .redLight
        
        //title = "Create Recipe"
    }
}

//MARK: - CreateRecipeViewDelegate
extension CreateRecipeViewController: CreateRecipeViewDelegate {
    func createRecipeButtonPressed() {
        print("CreateRecipeViewController: CreateRecipeViewDelegate -> createRecipeButtonPressed()")
        presenter?.createRecipe()
    }
}

//MARK: - CreateRecipeViewControllerProtocol
extension CreateRecipeViewController: CreateRecipeViewControllerProtocol {
    func sayHi() {
        print("HI!")
    }
}
