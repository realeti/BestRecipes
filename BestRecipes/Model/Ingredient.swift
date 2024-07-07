//
//  Ingredient.swift
//  BestRecipes
//
//  Created by nik on 02.07.24.
//

struct Ingredient: Codable {
    let id: Int
    let name: String
    let amount: Double
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case amount = "amount"
        case imageName = "image"
    }
    
    var weight: Int {
        Int(amount * 28.34952)
    }
}
