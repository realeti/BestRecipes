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
}

protocol DetailTableViewData: AnyObject {
    func numberOfIngredients() -> Int
    func ingredient(at index: Int) -> DetailIngredient
}

final class DetailPresenter {
    private weak var view: DetailViewProtocol?
    private var model: RecipeDetailModel

    init(view: DetailViewProtocol, router: RouterProtocol, model: RecipeDetailModel) {
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
