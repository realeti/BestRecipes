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
        
        #warning("убрать debug")
        //DEBUG
        let recipes: [Recipe] = DataManager.shared.getRecipesFrom(.favorites)
        let recipeDetailModel: RecipeDetailModel =
        RecipeDetailModel(
            title: recipes[0].title ?? "",
            instructions: recipes[0].instructions?[0].steps ?? [],
            rating: recipes[0].rating,
            reviewsCount: recipes[0].reviewsCount,
            imageURL: recipes[0].imageURL ?? "",
            ingredients: recipes[0].extendedIngredients?.map{ ingredient in
                DetailIngredient(
                    name: ingredient.name,
                    amount: ingredient.amount,
                    imageName: ingredient.imageName
                )
            } ?? []
        )
        print("МОДЕЛЬ:\n", recipeDetailModel)
        
        let vc = DetailViewController(model: recipeDetailModel)
        let view = DetailView()
        let presenter = DetailPresenter(view: view, model: recipeDetailModel)
        vc.presenter = presenter
        
        //DEBUG
        
        window?.rootViewController = UINavigationController(rootViewController: vc)//CustomTabBarController()
        window?.makeKeyAndVisible()
    }
}
