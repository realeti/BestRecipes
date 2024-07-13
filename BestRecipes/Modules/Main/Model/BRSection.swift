//
//  BRSection.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import Foundation

enum BRSection {
    case trending(model: [BRTrendingModel])
    case category(model: [BRCategoryModel])
    case popular(model: [BRPopularModel])
    case recent(model: [BRRecentModel])
    case cuisine(model: [BRCuisineModel])

    
    //MARK: - Headers
    
    var title: String {
        switch self {
        case .trending:
            return "Trending now 🔥"
        case .category:
            return ""
        case .popular:
            return ""
        case .recent:
            return "Recent Recipe"
        case .cuisine:
            return "Popular Cuisine"
        }
    }
}
