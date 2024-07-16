//
//  RecipeDetailModel.swift
//  BestRecipes
//
//  Created by Pavel Kostin on 04.07.2024.
//

import Foundation

struct RecipeDetailModel {
    let title: String
    //let instructions: [Step]?
    let instruction: [String: String]
    let rating: Double
    let reviewsCount: Int
    let imageURL: String
    let ingredients: [DetailIngredient]
}

struct DetailIngredient {
    let name: String
    let amount: Double
    let imageName: String
}

struct Empty {
    
}
