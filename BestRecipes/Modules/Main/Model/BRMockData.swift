//
//  MockData.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

struct BRMockData {
    
    static let shared = BRMockData()
    
    private let trending: BRListSection = {
        .trending([.init(rating: "4,5", title: "How to sharwama at home", imageName: "media2", timeRemaining: "",
                         author: "By Zeelicious foods", authorImageName: "author"),
                   .init(rating: "3,2", title: "How to sharwama at home", imageName: "media", timeRemaining: "",
                         author: "By Zeelicious foods", authorImageName: "author2"),
                   .init(rating: "3,2", title: "How to sharwama at home", imageName: "media2", timeRemaining: "",
                         author: "By Zeelicious foods", authorImageName: "author2")
        ])
    }()
    
    private let category: BRListSection = {
        .category([.init(rating: "", title: "Salad", imageName: "", timeRemaining: "",
                         author: "", authorImageName: ""),
                   .init(rating: "", title: "Breakfest", imageName: "", timeRemaining: "",
                         author: "", authorImageName: ""),
                   .init(rating: "", title: "Appetizer", imageName: "", timeRemaining: "",
                         author: "", authorImageName: ""),
                   .init(rating: "", title: "Noodle", imageName: "", timeRemaining: "",
                         author: "", authorImageName: ""),
                   .init(rating: "", title: "Lunch", imageName: "", timeRemaining: "",
                         author: "", authorImageName: ""),
        ])
    }()
    
    private let popular: BRListSection = {
        .popular([.init(rating: "", title: "Chicken and Vegetable wrap", imageName: "food1", timeRemaining: "5 Mins",
                        author: "", authorImageName: ""),
                  .init(rating: "", title: "Chicken and Vegetable wrap", imageName: "food2", timeRemaining: "5 Mins",
                        author: "", authorImageName: ""),
                  .init(rating: "", title: "Chicken and Vegetable wrap", imageName: "food1", timeRemaining: "5 Mins",
                        author: "", authorImageName: ""),
        ])
    }()
    
    private let recent: BRListSection = {
        .recent([.init(rating: "", title: "Kelewele Ghanian Recipe", imageName: "food3", timeRemaining: "",
                       author: "By Zeelicious Foods", authorImageName: "author"),
                 .init(rating: "", title: "Kelewele Ghanian Recipe", imageName: "food4", timeRemaining: "",
                       author: "By Zeelicious Foods", authorImageName: "author2"),
                 .init(rating: "", title: "Kelewele Ghanian Recipe", imageName: "food3", timeRemaining: "",
                       author: "By Zeelicious Foods", authorImageName: "author2"),
                 .init(rating: "", title: "Kelewele Ghanian Recipe", imageName: "food4", timeRemaining: "",
                       author: "By Zeelicious Foods", authorImageName: "author2"),
        ])
    }()
    
    private let cuisine: BRListSection = {
        .cuisine([.init(rating: "", title: "Ify's Kitchen", imageName: "avatar", timeRemaining: "",
                        author: "", authorImageName: ""),
                  .init(rating: "", title: "Kathryn Murphy", imageName: "avatar2", timeRemaining: "",
                        author: "", authorImageName: ""),
                  .init(rating: "", title: "Jerome Bell", imageName: "avatar3", timeRemaining: "",
                        author: "", authorImageName: ""),
        ])
    }()
    
    
    var pageData: [BRListSection] {
        [trending, category, popular, recent, cuisine]
    }
}
