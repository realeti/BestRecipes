//
//  Instruction.swift
//  BestRecipes
//
//  Created by nik on 11.07.24.
//

import Foundation

struct Instruction: Codable {
    let steps: [Step]?
}

struct Step: Codable {
    let number: Int?
    let step: String?
}
