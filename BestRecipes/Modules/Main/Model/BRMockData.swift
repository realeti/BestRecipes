//
//  MockData.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

struct BRMockData {
    
    static let shared = BRMockData()
    private init() {}
    
    private let trending: BRSection = {
        .trending(model: [.init(id: 0, title: "Title1", author: "Author1", rating: "0", imageURL: "media")
        ])
    }()
    
    private let category: BRSection = {
        .category(model: [.init(categoryType: "Category")
        ])
    }()
    
    private let popular: BRSection = {
        .popular(model: [.init(title: "Title1", imageURL: "media", readyInMinutes: 00)
        ])
    }()
    
    private let recent: BRSection = {
        .recent(model: [.init(title: "Title", imageURL: "media", author: "Author")
        ])
    }()
    
    private let cuisine: BRSection = {
        .cuisine(model: [.init(title: "Title1", imageURL: "avatar")
        ])
    }()
    
    
    var pageData: [BRSection] {
        [trending, category, popular, recent, cuisine]
    }
}
