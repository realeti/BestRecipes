//
//  Ingredient.swift
//  BestRecipes
//
//  Created by nik on 02.07.24.
//

struct Ingredient {
    let id: Int
    let name: String
    let weight: Int
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case weight = "weight"
        case image = "image"
    }
}
