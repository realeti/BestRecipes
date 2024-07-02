//
//  BRListSection.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import Foundation

enum BRListSection {
    case trending([BRListItem])
    case category([BRListItem])
    case popular([BRListItem])
    case recent([BRListItem])
    case cuisine([BRListItem])
    
    var items: [BRListItem] {
        switch self {
        case .trending(let items),
                .category(let items),
                .popular(let items),
                .recent(let items),
                .cuisine(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    //MARK: - Headers
    
    var title: String {
        switch self {
        case .trending:
            return "Trending now 🔥"
        case .category:
            return "Popular category"
        case .popular:
            return ""
        case .recent:
            return "Recent recipe"
        case .cuisine:
            return "Popular cuisine"
        }
    }
}
