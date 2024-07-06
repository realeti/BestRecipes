//
//  RecipePreview.swift
//  BestRecipes
//
//  Created by nik on 03.07.24.
//

import Foundation

struct RecipePreview: Decodable {
    let id: Int
    let title: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "image"
    }
}
