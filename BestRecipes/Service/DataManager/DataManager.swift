//
//  DataManager.swift
//  BestRecipes
//
//  Created by nik on 04.07.24.
//

import Foundation

enum Link: String {
    case search = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&number=100&apiKey="
    case image = "https://img.spoonacular.com/ingredients_100x100/"
}

enum RecipeType: String {
    case cuisine = "&cuisine="
    case type = "&type="
    case search = "&query="
    case trend = "&sort=meta-score&sortDirection=desc"
}

final class DataManager {
    static let shared = DataManager()
    
    private var imageCaсhe: [String: Data] = [:]
    
    private let apiKeys: [String] = [
        "cc3538ef4d1448949d8c1f17cf5703c1"
    ]
    
    private var apiKeyIndex = 0
    
    private init() {}
    
    func getRecepies(
        type: RecipeType,
        by key: String = "",
        offset: Int = 0,
        completion: @escaping([Recipe]) -> Void
    ) {
        let link = Link.search.rawValue + apiKeys[apiKeyIndex] + type.rawValue + key + "&offset=\(offset)"
        
        NetworkManager.shared.fetch(SearchResult.self, from: link) { result in
            switch result {
            case .success(let someSearch):
                completion(someSearch.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImage(_ url: String, completion: @escaping(Data) -> Void) {
        if let data = imageCaсhe[url] {
            completion(data)
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { [unowned self] result in
            switch result {
            case .success(let data):
                imageCaсhe[url] = data
                completion(data)
            case .failure(_):
                completion(Data())
            }
        }
    }
    
    func addToFavorites(_ recipe: Recipe) {
        
    }
}
