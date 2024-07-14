//
//  Presenter.swift
//  tests
//
//  Created by Pavel Kostin on 12.07.2024.
//

import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setImage(url: String)
    func setRatingText(_ text: String)
    func setReviewsCount(_ count: String)
    func setInstructions(_ instructions: [Step])
    func updateIngredients(_ ingredients: [DetailIngredient])
}

protocol DetailTableViewData: AnyObject {
    func numberOfIngredients() -> Int
    func ingredient(at index: Int) -> DetailIngredient
}


final class DetailPresenter {
    private weak var view: DetailViewProtocol?
    private var model: RecipeDetailModel

    init(view: DetailViewProtocol, model: RecipeDetailModel) {
        self.view = view
        self.model = model
    }

    func viewDidLoad() {
        view?.setTitle(model.title)
        view?.setImage(url: model.imageURL)
        view?.setRatingText("\(model.rating)")
        view?.setReviewsCount("(\(model.reviewsCount) reviews)")
        view?.setInstructions(model.instructions ?? [])
        view?.updateIngredients(model.ingredients)
    }
}
