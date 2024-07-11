//
//  BRTrendingModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 07.07.2024.
//

import Foundation

struct BRTrendingModel {
    let id: Int
    let title: String
    let author: String
    let rating: String
    let imageURL: String?
}


extension BRTrendingModel {
    init(_ recipe: Recipe) {
        self.id = recipe.id
        self.title = recipe.title ?? "Title"
        self.author = recipe.author ?? "Author"
        self.rating = String(format: "%0.1f", 5 * (recipe.rating ?? 1) / 100)
        self.imageURL = recipe.imageURL ?? "ImageURL"
    }
}
