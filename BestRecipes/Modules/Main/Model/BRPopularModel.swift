//
//  BRPopularModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 07.07.2024.
//

import Foundation

struct BRPopularModel {
    let title: String
    let imageURL: String?
    let readyInMinutes: Int
}


extension BRPopularModel {
    init(_ recipe: Recipe) {
        self.title = recipe.title ?? "Popular"
        self.imageURL = recipe.imageURL
        self.readyInMinutes = recipe.readyInMinutes ?? 00
    }
}
