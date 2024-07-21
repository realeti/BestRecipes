//
//  SceneDelegate.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CustomTabBarController()
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}
