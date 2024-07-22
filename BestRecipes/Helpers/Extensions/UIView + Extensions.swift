//
//  UIView + ext.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for view in subviews {
            addSubview(view)
        }
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
}

extension UIView {
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
