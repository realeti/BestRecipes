//
//  BRCuisineModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 07.07.2024.
//

import Foundation

struct BRCuisineModel {
    let title: String
    let imageURL: String?
}


extension BRCuisineModel {
    init(_ recipe: Recipe) {
        self.title = recipe.title ?? "Title"
        self.imageURL = recipe.imageURL
    }
}
