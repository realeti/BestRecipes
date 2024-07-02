//
//  TestVC.swift
//  BestRecipes
//
//  Created by nik on 02.07.24.
//

import UIKit

final class TestVC: UITableViewController {
    let networkManager = NetworkManager.shared
    let cellID = "recipe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .systemBackground
        setupNavBar()
    }
    
    private func showRecipes() {
        print(#function)
    }
    
    private func searcRecipes() {
        print(#function)
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
        5 //10 max!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        NetworkManager.shared.fetch(Recipe.self, from: Recipe.giveRandomRecipe()) { fetchResult in
            switch fetchResult {
            case .success(let recipe):
                NetworkManager.shared.fetchImage(from: recipe.imageURL) { result in
                    switch result {
                    case .success(let imageData):
                        cell.imageView?.image = UIImage(data: imageData)
                        cell.textLabel?.text = recipe.title
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
}
