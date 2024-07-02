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
    //let reviewsCount: Int
    let imageURL: String
    //let extendedIngredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case instructions = "instructions"
        case author = "sourceName"
        case rating = "spoonacularScore"
        //case reviewsCount = "reviewsCount"
        case imageURL = "image"
        //case extendedIngredients = "extendedIngredients"
    }
    
    static func giveRandomRecipe() -> String {
        "https://api.spoonacular.com/recipes/\(Int.random(in: 1...999999))/information?apiKey=cc3538ef4d1448949d8c1f17cf5703c1"
    }
}
