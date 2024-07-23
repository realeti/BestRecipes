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
        //window?.rootViewController = CustomTabBarController()
        let builder = Builder()
        window?.rootViewController = builder.createOnboardingModule(router: Router(navigationController: UINavigationController(), builder: builder))
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}
