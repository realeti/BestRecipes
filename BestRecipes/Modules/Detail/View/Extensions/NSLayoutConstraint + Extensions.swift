//
//  NSLayoutConstraint + Extensions.swift
//  BestRecipes
//
//  Created by realeti on 16.07.2024.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
