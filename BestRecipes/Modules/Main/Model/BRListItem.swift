//
//  BRListItem.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

struct BRListItem {
    let rating: String
    let title: String
    let imageName: String?
    let timeRemaining: String
    let author: String
    let authorImageName: String?
    
    var image: UIImage? {
        return UIImage(named: imageName!)
    }
    
    var authorImage: UIImage? {
        return UIImage(named: authorImageName!)
    }
}


extension BRListItem {
    init(_ recipe: Recipe) {
        self.rating = recipe.rating.description
        self.title = recipe.title
        self.imageName = recipe.imageURL
        self.author = recipe.author
        self.timeRemaining = recipe.readyInMinutes.description
        self.authorImageName = "author"
    }
}
