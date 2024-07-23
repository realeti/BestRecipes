//
//  Presenter.swift
//  tests
//
//  Created by Pavel Kostin on 12.07.2024.
//

import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    func setRecipeTitle(_ title: String)
    func setImage(url: String)
    func setRating(_ rating: Double)
    func setReviewsCount(_ count: String)
    //func setInstructions(_ instructions: [Step])
    func setInstructions(_ instruction: [String : String])
    func updateIngredients(_ ingredients: [DetailIngredient])
    func didUpdateRecipeImage(_ imageData: Data)
    func didUpdateIngredientImage(_ imageData: Data, indexPath: IndexPath)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, router: RouterProtocol, model: RecipeDetailModel)
    var ingredients: [DetailIngredient] { get }
    func loadRecipeImage(with imageUrl: String)
    func loadIngredientImage(with imageUrl: String, indexPath: IndexPath)
}

final class DetailPresenter: DetailPresenterProtocol {
    // MARK: - Private Properties
    private weak var view: DetailViewProtocol?
    private var model: RecipeDetailModel
    
    // MARK: - Public Properties
    var ingredients: [DetailIngredient] {
        get {
            return model.ingredients
        }
    }
    
    // MARK: - Init
    required init(view: DetailViewProtocol, router: RouterProtocol, model: RecipeDetailModel) {
        self.view = view
        self.model = model
    }

    func loadData() {
        view?.setRecipeTitle(model.title)
        view?.setImage(url: model.imageURL)
        view?.setRating(model.rating)
        view?.setReviewsCount("(\(model.reviewsCount) reviews)")
        view?.setInstructions(model.instruction)
        view?.updateIngredients(model.ingredients)
    }
}

// MARK: - Load Recipe Image
extension DetailPresenter {
    func loadRecipeImage(with imageUrl: String) {
        DataManager.shared.getImage(imageUrl) { [weak self] imageData in
            self?.view?.didUpdateRecipeImage(imageData)
        }
    }
}

// MARK: - Load Ingredient Image
extension DetailPresenter {
    func loadIngredientImage(with imageUrl: String, indexPath: IndexPath) {
        /*DataManager.shared.getImage(imageUrl) { [weak self] imageData in
            self?.view?.didUpdateIngredientImage(imageData, indexPath: indexPath)
        }*/
    }
}
