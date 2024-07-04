//
//  BRUrlString.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 04.07.2024.
//

import Foundation

enum BRUrlString {
    static var main: String {
        "https://api.spoonacular.com/recipes/random?apiKey=94a3e904ec2d4cc8bab79ce9735f4d49&number=2&instructionsRequired=true"
    }
    
    static var popular: String {
        "https://api.spoonacular.com/recipes/random?&apiKey=94a3e904ec2d4cc8bab79ce9735f4d49&number=5&type=main%20course&tags=main%20course"
//        "https://api.spoonacular.com/recipes/random?id&apiKey=94a3e904ec2d4cc8bab79ce9735f4d49&number=5&type=salad"
    }
}
