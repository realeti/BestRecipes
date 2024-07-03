//
//  SearchResult.swift
//  BestRecipes
//
//  Created by nik on 03.07.24.
//

import Foundation

struct SearchResult: Decodable {
    let results: [RecipePreview]
    let offset: Int
    let number:  Int
    let totalResults: Int
}
