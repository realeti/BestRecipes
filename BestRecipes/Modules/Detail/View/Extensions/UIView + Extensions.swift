//
//  UIView + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 16.07.2024.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
