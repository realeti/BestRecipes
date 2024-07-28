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
            //
        }*/
        
        let builder = Builder()
        let pageViewController = builder.createOnboardingPageContainer()
        let router = OnboardingRouter(builder: builder, pageContainer: pageViewController)
        
        // Create OnboardingHomeViewController
        let onboardingHomeVC = builder.createOnboardingHomeModule(router: router)
        window?.rootViewController = onboardingHomeVC
        
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}
