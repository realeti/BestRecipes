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
        
        view.backgroundColor = .greyBase
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
