//
//  DataManager.swift
//  BestRecipes
//
//  Created by nik on 04.07.24.
//

import Foundation

enum Link: String {
    case search = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true"
    case bulk = "https://api.spoonacular.com/recipes/informationBulk?"
    case autocomplite = "https://api.spoonacular.com/recipes/autocomplete?"
    case image = "https://img.spoonacular.com/ingredients_100x100/"
}

enum RecipeType: String {
    case cuisine = "cuisine="
    case type = "type="
    case search = "query="
    case trend = "sort=popularity&sortDirection=desc"
}

struct DataManager {
    
    static let shared = DataManager()
    
    private let apiKeys: [String] = [
        "cc3538ef4d1448949d8c1f17cf5703c1"
    ]
    
    private var apiKeyIndex = 0
    
    private init() {}
    
    private func getRecepies(numbers: [Int] = [], by key: String = "", completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
    }
    
    private func addToFavorites(_ recipe: Recipe) {
        
    }
    
}


//getRecipes with numbers
//get recipes by cuisine
//get recipes by type
//
