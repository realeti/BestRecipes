//
//  UIImageView + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 10.07.2024.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, backgroundColor: UIColor = .clear, contentMode: UIView.ContentMode, cornerRadius: CGFloat = 0) {
        self.init()
        
        self.image = image
        self.backgroundColor = backgroundColor
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
