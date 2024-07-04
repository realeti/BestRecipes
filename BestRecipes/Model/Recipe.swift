//
//  Recipe.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

struct Recipe: Decodable {
    let id: Int
    let title: String
    let instructions:  String?
    let author: String
    let rating: Double
    let readyInMinutes: Int
    //let reviewsCount: Int
    let imageURL: String
    let extendedIngredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case instructions = "instructions"
        case author = "sourceName"
        case rating = "spoonacularScore"
        case readyInMinutes = "readyInMinutes"
        //case reviewsCount = "reviewsCount"
        case imageURL = "image"
        case extendedIngredients = "extendedIngredients"
    }
}

// struct to convert into it from response dictionary
struct ResponseRecipe: Decodable {
    let recipes: [Recipe]
}
