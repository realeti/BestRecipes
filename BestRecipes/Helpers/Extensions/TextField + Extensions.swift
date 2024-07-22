//
//  TextField + ext.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

extension UITextField {
    func setupLeftImage() {
        let imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        imageView.image = .search
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
}
