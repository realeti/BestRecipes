//
//  UIButton + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 10.07.2024.
//

import UIKit

extension UIButton {
    convenience init(backgroundImage: UIImage, transform: CGAffineTransform = .identity) {
        self.init(type: .system)
        
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
