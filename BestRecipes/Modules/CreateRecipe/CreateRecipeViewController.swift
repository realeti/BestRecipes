//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by nik on 10.07.24.
//

import UIKit

protocol CreateRecipeViewControllerProtocol: AnyObject {
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
        
        view.backgroundColor = .white
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
        presenter?.createRecipe()
    }
}

//MARK: - CreateRecipeViewControllerProtocol
extension CreateRecipeViewController: CreateRecipeViewControllerProtocol {
}
