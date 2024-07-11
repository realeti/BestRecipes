//
//  BRCategoryModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 04.07.2024.
//

import Foundation

struct BRCategoryModel {
    let type: String
    let request : String
}


extension BRCategoryModel {
    init(_ recipe: Recipe) {
        self.type = recipe.dishTypes?.first ?? "Category"
        self.request = ""
    }
}

