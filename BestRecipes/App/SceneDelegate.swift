//
//  SceneDelegate.swift
//  BestRecipes
//
//  Created by realeti on 30.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        /*let dataManager = DataManager.shared
        
        if dataManager.isOnboardingCompleted {
            window?.rootViewController = CustomTabBarController()
        } else {
            window?.rootViewController = OnboardingHomeViewController()
        }*/
        
        window?.rootViewController = OnboardingHomeViewController()
        
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}
