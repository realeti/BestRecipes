//
//  Font.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

enum Font: String {
    
    case poppinsBold = "Poppins-Bold"
    case poppinsRegular = "Poppins-Regular"
    case poppinsSemiBold = "Poppins-SemiBold"
    
    static func getFont(_ font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
