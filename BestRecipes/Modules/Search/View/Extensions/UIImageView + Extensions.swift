//
//  UIImageView + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 10.07.2024.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode, cornerRadius: CGFloat = 0) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
