//
//  BRCategoryModel.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 04.07.2024.
//

import Foundation

struct BRCategoryModel {
    let categoryType: String
}


extension BRCategoryModel {
    init(_ recipe: Recipe) {
        self.categoryType = "Category"
    }
}
