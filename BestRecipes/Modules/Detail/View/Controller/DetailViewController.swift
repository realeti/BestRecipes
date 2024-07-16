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
        detailView.updateTableView()
    }
    
    func didUpdateRecipeImage(_ imageData: Data) {
        if !imageData.isEmpty {
            self.detailView.imageFood.image = UIImage(data: imageData)
        } else {
            self.detailView.imageFood.image = UIImage(resource: .noimage)
        }
    }
}
