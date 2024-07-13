//
//  UILabel + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 10.07.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", color: UIColor = .white, font: Font, fontSize: CGFloat, numberOfLines: Int = 1) {
        self.init()
        
        self.text = text
        self.textColor = color
        self.font = Font.getFont(font, size: fontSize)
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
