//
//  UIStackView + ext.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }

    func addArrangedSubviews(_ subviews: UIView...) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }
}
