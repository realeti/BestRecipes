//
//  DetailViewController.swift
//  BestRecipes
//
//  Created by realeti on 15.07.2024.
//


import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Private properties
    private var detailView: DetailView!
    
    // MARK: - Public Properties
    var presenter: DetailPresenter!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        detailView = DetailView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        presenter.loadData()
    }
}

// MARK: - Set Delegates
extension DetailViewController {
    private func setDelegates() {
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
    }
}

// MARK: - Detail Delegate methods
extension DetailViewController: DetailViewProtocol {
    func setRecipeTitle(_ title: String) {
        detailView.topLabel.text = title
    }
    
    func setImage(url: String) {
        presenter.loadRecipeImage(with: url)
    }
    
    func setRating(_ rating: Double) {
        detailView.rateLabel.text = String(format: "%.1f", rating)
    }
    
    func setReviewsCount(_ count: String) {
        detailView.reviewsLabel.text = count
    }
    
    func setInstructions(_ instruction: [String : String]) {
        detailView.detailTextView.updateInstructionText(with: instruction)
    }
    
    func updateIngredients(_ ingredients: [DetailIngredient]) {
        //detailView.ingredientAmountLabel.text = "\(ingredients.count)"
        detailView.ingredientAmountLabel.text = "5" // mock
    }
    
    func didUpdateRecipeImage(_ imageData: Data) {
        DispatchQueue.main.async {
            if !imageData.isEmpty {
                self.detailView.imageFood.image = UIImage(data: imageData)
            } else {
                self.detailView.imageFood.image = UIImage(resource: .noimage)
            }
        }
    }
    
    func didUpdateIngredientImage(_ imageData: Data, indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.detailView.tableView.cellForRow(at: indexPath) as? DetailViewCell {
                if !imageData.isEmpty {
                    cell.ingredientImageView.image = UIImage(data: imageData)
                } else {
                    cell.ingredientImageView.image = UIImage(resource: .noimage)
                }
            }
        }
    }
}

// MARK: - TableView Data Source
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //presenter.ingredients.count
        return 5 // mock
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.detailTableCell, for: indexPath) as? DetailViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        let ingredientName = presenter.ingredients[indexPath.row].name
        let ingredientAmount = presenter.ingredients[indexPath.row].amount
        cell.configure(name: ingredientName, amount: ingredientAmount, indexPath: indexPath)
        return cell
    }
}

// MARK: - TableView Delegate
extension DetailViewController: UITableViewDelegate {
    //
}

// MARK: - Detail TableView Cell Delegate
extension DetailViewController: DetailViewCellProtocol {
    func loadIngredientImage(for cell: DetailViewCell, at indexPath: IndexPath) {
        //let ingredient = presenter.ingredients[indexPath.row]
        //let imageUrl = ingredient.imageName
        //presenter.loadIngredientImage(with: imageUrl, indexPath: indexPath)
    }
}
