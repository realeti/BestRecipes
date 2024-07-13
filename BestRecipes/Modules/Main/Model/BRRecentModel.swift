//
//  BRRecentModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 09.07.2024.
//

import Foundation

struct BRRecentModel {
    let title: String
    let imageURL: String
    let author: String
}


extension BRRecentModel {
    init(_ recipe: Recipe) {
        self.title = recipe.title ?? "Title"
        self.imageURL = recipe.imageURL ?? "ImageURL"
        self.author = recipe.author ?? "Author"
    }
}
