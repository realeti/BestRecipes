//
//  TestVC.swift
//  BestRecipes
//
//  Created by nik on 02.07.24.
//

import UIKit

final class TestVC: UITableViewController {
    let dataManager = DataManager.shared
    let cellID = "recipe"
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .systemBackground
        setupNavBar()
    }
    
    private func showRecipes() {
        dataManager.getRecepies(
            type: .cuisine,
            by: CuisineType.getRandom().rawValue,
            amount: Int.random(in: 30...100)
        ) { [unowned self] result in
            recipes = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func searcRecipes() {
        if !recipes.isEmpty {
            dataManager.addRecipe(recipes.first!, to: .favorites)
        }
        recipes = dataManager.getRecipesFrom(.favorites)
        
        self.tableView.reloadData()
    }
}

private extension TestVC {
    func setupNavBar() {
        title = "TestVC"
                
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .play,
            primaryAction: UIAction{ [unowned self] _ in
                showRecipes()
            }
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .search,
            primaryAction: UIAction{ [unowned self] _ in
                searcRecipes()
            }
        )
    }
}

// MARK: - UITableViewDataSource
extension TestVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = recipe.title
        
        dataManager.getImage(recipe.imageURL ?? "") { imageData in
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }
}
