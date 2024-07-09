//
//  Recipe.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String?
    let instructions:  String?
    let author: String?
    let rating: Double?
    let readyInMinutes: Int?
    let imageURL: String?
    let dishTypes: [DishTypes]
    let extendedIngredients: [Ingredient]?
    
    struct DishTypes: Codable {
        let name: String
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case instructions = "instructions"
        case author = "sourceName"
        case rating = "spoonacularScore"
        case readyInMinutes = "readyInMinutes"
        case imageURL = "image"
        case dishTypes = "dishTypes"
        case extendedIngredients = "extendedIngredients"
    }
    
    let reviewsCount: Int = Int.random(in: 200...500)
}
