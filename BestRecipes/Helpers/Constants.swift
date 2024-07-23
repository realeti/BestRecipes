//
//  Constants.swift
//  BestRecipes
//
//  Created by realeti on 05.07.2024.
//

import Foundation

struct K {
    // MARK: - Navigation Titles
    static let homeTitle = "Get amazing recipes\nfor cooking"
    static let favoriteTitle = "Saved recipes"
    static let notificationTitle = "Notification"
    static let profileTitle = "My profile"
    static let detailTitle = "Recipe detail"
    static let trendingTitle = "Trending now"
    static let createRecipeTitle = "Create recipe"
    static let recentRecipesTitle = "Recent recipes"
    static let popularCuisineTitle = "Popular Cuisine"
    
    // MARK: - Reusable
    static let myRecipesCell = "searchCell"
    static let emptyCell = "emptySearchCell"
    static let searchHeaderView = "searchHeaderView"
    static let trendingCell = "trendingCell"
    static let detailTableCell = "detailTableCell"
    static let detailHeaderView = "detailHeaderView"
    
    // MARK: - Onboarding
    enum Onboarding: String {
        case recipesCount = "100k+ "
        case premiumRecipes = "Premium recipes"
        case bestRecipe = "Best\nRecipe"
        case findBestRecipes = "Find best recipes for cooking"
        case getStartedButtonTitle = "Get started"
    }
    
    // MARK: - Search
    static let searchPlaceholer = "How to make..."
    static let emptySearchText = "Nothing here, keep searching!"
    static let emptyTrendingText = "Nothing here, network problem..."
    
    // MARK: - Profile
    static let profileAvatarName = "ProfileAvatar"
    static let myRecipes = "My recipes"
    
    // MARK: - Detail
    static let instructions = "Instructions"
    static let ingredients = "Ingredients"
    
    // MARK: - Mock Instruction
    static let step1 = "Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop."
    static let step2 = "Place chopped eggs in a bowl."
    static let step3 = "Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice."
    static let step4 = "Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper."
    static let stepRed = "Stir and serve on your favorite bread or crackers."
    
    private init () {}
}
