//
//  DetailViewController..swift
//
//
//  Created by Xcode on 10.06.2024.
//


import UIKit

final class DetailViewController: UIViewController {
    private let customView = DetailView()
    var presenter: DetailPresenter?

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setImage(url: String) {
        presenter?.loadRecipeImage(with: url)
    }
    
    func setRatingText(_ text: String) {
        customView.rateLabel.text = text
    }
    
    func setReviewsCount(_ count: String) {
        customView.reviewsLabel.text = count
    }
    
    func setInstructions(_ instructions: [Step]) {
        customView.detailTextView.updateInstructionText(with: instructions)
    }
    
    func updateIngredients(_ ingredients: [DetailIngredient]) {
        customView.ingredients = ingredients
        customView.updateTableView()
    }
    
    func didUpdateRecipeImage(_ imageData: Data) {
        if !imageData.isEmpty {
            self.customView.imageFood.image = UIImage(data: imageData)
        } else {
            self.customView.imageFood.image = UIImage(resource: .noimage)
        }
    }
}
