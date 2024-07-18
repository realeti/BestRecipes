//
//  ScreenSizeManager.swift
//  BestRecipes
//
//  Created by realeti on 18.07.2024.
//

import UIKit

struct ScreenSizeManager {
    static var screenWidth: CGFloat {
        if #available(iOS 15.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                fatalError("No window scene available")
            }
            return windowScene.screen.bounds.width
        } else {
            return UIScreen.main.bounds.width
        }
    }
}
