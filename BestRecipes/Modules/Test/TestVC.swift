////
////  TestVC.swift
////  BestRecipes
////
////  Created by nik on 02.07.24.
////
//
//import UIKit
//
//final class TestVC: UITableViewController {
//    let networkManager = NetworkManager.shared
//    let cellID = "recipe"
//    let bulkRecipesURL = "https://api.spoonacular.com/recipes/informationBulk?apiKey=cc3538ef4d1448949d8c1f17cf5703c1&ids=756814,636589,716432"
//    let searchRecipesURL = "https://api.spoonacular.com/recipes/complexSearch?apiKey=cc3538ef4d1448949d8c1f17cf5703c1&type=drink"
//    var recipes: [Recipe] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
//        view.backgroundColor = .systemBackground
//        setupNavBar()
//    }
//    
//    private func showRecipes() {
//        NetworkManager.shared.fetch([Recipe].self, from: bulkRecipesURL) { [unowned self] result in
//            switch result {
//            case .success(let recipesData):
//                recipes = recipesData
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    private func searcRecipes() {
//        NetworkManager.shared.fetch(SearchResult.self, from: searchRecipesURL) { [unowned self] result in
//            switch result {
//            case .success(let searchResult):
//                recipes = searchResult.results.map {
//                    let recipe = $0
//                    return Recipe(
//                        id: recipe.id,
//                        title: recipe.title,
//                        instructions: "",
//                        author: "",
//                        rating: 0,
//                        readyInMinutes: 0,
//                        imageURL: recipe.imageURL,
//                        extendedIngredients: []
//                    )
//                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
//
//private extension TestVC {
//    func setupNavBar() {
//        title = "TestVC"
//                
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            systemItem: .play,
//            primaryAction: UIAction{ [unowned self] _ in
//                showRecipes()
//            }
//        )
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            systemItem: .search,
//            primaryAction: UIAction{ [unowned self] _ in
//                searcRecipes()
//            }
//        )
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension TestVC {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        recipes.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let recipe = recipes[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        
//        cell.textLabel?.text = recipe.title
//        
//        NetworkManager.shared.fetchImage(from: recipe.imageURL) { result in
//            switch result {
//            case .success(let imageData):
//                cell.imageView?.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//        return cell
//    }
//}
