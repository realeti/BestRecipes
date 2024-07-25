//
//  DataManager.swift
//  BestRecipes
//
//  Created by nik on 04.07.24.
//

import Foundation

enum Link: String {
    case search = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&fillIngredients=true&apiKey="
    case image = "https://img.spoonacular.com/ingredients_100x100/"
}

enum RecipeType: String {
    case cuisine = "&cuisine="
    case type = "&type="
    case search = "&query="
    case trend = "&sort=meta-score&sortDirection=desc"
}

enum CuisineType: String, CaseIterable {
    case african = "African"
    case asian = "Asian"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
    
    static func getRandom() -> CuisineType {
        allCases.randomElement()!
    }
}

enum MealTypes: String, CaseIterable {
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
    
    static func getRandom() -> MealTypes {
        allCases.randomElement()!
    }
}

enum SavedRecipesType: String {
    case mine = "myRecipes"
    case favorites = "favoritesRecipes"
    case recent = "recentRecipes"
}

//protocol DataService {
//    func getRecepies(type: RecipeType, by key: String, offset: Int, completion: @escaping([Recipe]) -> Void)
//    func getImage(_ url: String, completion: @escaping(Data) -> Void)
//    func getRecipesFrom(_ storage: SavedRecipesType) -> [Recipe]
//    func addRecipe(_ recipe: Recipe, to storage: SavedRecipesType)
//    func deleteRecipe(_ recipe: Recipe, from storage: SavedRecipesType)
//}


final class DataManager {
    
    static let shared = DataManager()
    private let fileManager = FileManagerController.shared
    
    private let apiKeys: [String] = [
        "cc3538ef4d1448949d8c1f17cf5703c1",
        "b00472aa0b6b4e94b37c893f41ac110c",
        "5aacdbb3cbe1434194ec06aac794bec6",
        "94a3e904ec2d4cc8bab79ce9735f4d49",
        "67815760a10949b7abd4174a271dbd1d",
        "27e0d44421784a0881805de490c3972c",
        "70566ce42eb64166a684c1f887b1e7bb",
        "36486cc9df8a4c798a7fd05ab4a8a483",
        "d5fd5ac1cb55405a8159bab08d547d52"
    ]
    private var imageCaсhe: [String: Data] = [:]
    private var recipeCache: [String: [Recipe]] = [:]
    private var apiKeyIndex = 1
    
    private let onboardingCompletedKey = "onboardingCompleted"
    
    private init() {}
    
    func passNextApiKey() -> Bool {
        if apiKeyIndex < apiKeys.count - 1 {
            apiKeyIndex += 1
            return true
        }
        return false
    }
    
    func getRecepies(
        type: RecipeType,
        by key: String = "",
        offset: Int = 0,
        amount: Int = 10,
        completion: @escaping([Recipe]) -> Void
    ) {
        let url = Link.search.rawValue
                    + apiKeys[apiKeyIndex]
                    + "&number=\(amount)"
                    + type.rawValue + key
                    + "&offset=\(offset)"
        
        if let data = recipeCache[url] {
            completion(data)
            return
        }
        
        NetworkManager.shared.fetch(SearchResult.self, from: url) { [unowned self] result in
            switch result {
            case .success(let searchResult):
                recipeCache[url] = searchResult.results
                completion(searchResult.results)
            case .failure(let error):
                print(error)
                completion([])
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
    
    func getRecipesFrom(_ storage: SavedRecipesType) -> [Recipe] {
        if let recipesData = UserDefaults.standard.data(forKey: storage.rawValue),
           let recipes = try? JSONDecoder().decode([Recipe].self, from: recipesData) {
            return recipes
        }
        
        return []
    }
    
    func addRecipe(_ recipe: Recipe, to storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        if recipes.contains(where: { $0.id == recipe.id}) {
            return
        }
        
        recipes.append(recipe)
        
        if let item = try? JSONEncoder().encode(Array(recipes)) {
            UserDefaults.standard.set(item, forKey: storage.rawValue)
        }
    }
    
    func deleteRecipe(_ recipe: Recipe, from storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        
        recipes.remove(at: index)
        
        if let item = try? JSONEncoder().encode(Array(recipes)) {
            UserDefaults.standard.set(item, forKey: storage.rawValue)
        }
    }
}

// MARK: - File Manager methods
extension DataManager {
    func saveImage(_ imageName: String, imageData: Data) {
        fileManager.saveImage(imageName, imageData: imageData)
    }
    
    func loadImage(imageUrl: String) -> Data? {
        fileManager.loadImage(imageUrl: imageUrl)
    }
}

// MARK: - Onboarding methods
extension DataManager {
    func markOnboardingAsCompleted() {
        UserDefaults.standard.set(true, forKey: onboardingCompletedKey)
    }
    
    var isOnboardingCompleted: Bool {
        return UserDefaults.standard.bool(forKey: onboardingCompletedKey)
    }
}
