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
    var presenter: DetailPresenter?
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        detailView = DetailView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        presenter?.loadData()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setRecipeTitle(_ title: String) {
        detailView.topLabel.text = title
    }
    
    func setImage(url: String) {
        presenter?.loadRecipeImage(with: url)
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
        detailView.ingredients = ingredients
        detailView.updateTableViewHeight()
    }
    
    func didUpdateRecipeImage(_ imageData: Data) {
        DispatchQueue.main.async {
            if !imageData.isEmpty {
                self.detailView.imageFood.image = UIImage(data: imageData)
            } else {
                self.detailView.imageFood.image = UIImage(resource: .food1)
            }
        }
    }
}

// MARK: - TableView Data Source
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.detailTableCell, for: indexPath) as? DetailViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: "Test", gram: "200")
        return cell
    }
}

// MARK: - TableView Delegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.detailHeaderView) as? DetailHeaderView else {
            return UIView()
        }
        headerView.configure(itemsCount: 5)
        return headerView
    }
}
