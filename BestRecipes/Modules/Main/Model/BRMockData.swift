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
        .trending(model: [.init(id: 0, title: "Title1", author: "Author1", authorImage: "emptyAvatar", rating: "0", imageURL: "food1"),
                          .init(id: 0, title: "Title1", author: "Author1", authorImage: "emptyAvatar", rating: "0", imageURL: "food2"),
                          .init(id: 0, title: "Title1", author: "Author1", authorImage: "emptyAvatar", rating: "0", imageURL: "food3"),
                          .init(id: 0, title: "Title1", author: "Author1", authorImage: "emptyAvatar", rating: "0", imageURL: "food4"),
        ])
    }()
    
    private let category: BRSection = {
        .category(model: [.init(type: "Main Course", request: ""),
                          .init(type: "Salad", request: ""),
                          .init(type: "Lunch", request: ""),
                          .init(type: "Dinner", request: ""),
                          .init(type: "Breakfest", request: ""),
        ])
    }()
    
    private let popular: BRSection = {
        .popular(model: [.init(title: "Title1", imageURL: "food1", readyInMinutes: 00),
                         .init(title: "Title1", imageURL: "food2", readyInMinutes: 00),
                         .init(title: "Title1", imageURL: "food3", readyInMinutes: 00),
                         .init(title: "Title1", imageURL: "food4", readyInMinutes: 00)
        ])
    }()
    
    private let recent: BRSection = {
        .recent(model: [.init(title: "Title", imageURL: "media", author: "Author")
        ])
    }()
    
    private let cuisine: BRSection = {
        .cuisine(model: [.init(title: "Title1", imageURL: "media"),
                         .init(title: "Title1", imageURL: "food1"),
                         .init(title: "Title1", imageURL: "food2"),
                         .init(title: "Title1", imageURL: "food3")
        ])
    }()
    
    
    var pageData: [BRSection] {
        [trending, category, popular, recent, cuisine]
    }
}
