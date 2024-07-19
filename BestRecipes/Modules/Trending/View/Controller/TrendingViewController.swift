//
//  TrendingViewController.swift
//  BestRecipes
//
//  Created by realeti on 13.07.2024.
//

import UIKit

final class TrendingViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: TrendingPresenterProtocol!
    
    // MARK: - Private properties
    private var trendingView: TrendingView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        trendingView = TrendingView()
        view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
}

// MARK: - Set Delegates
extension TrendingViewController {
    private func setDelegates() {
        trendingView.trendingCollection.dataSource = self
        trendingView.trendingCollection.delegate = self
    }
}

// MARK: - Trending Delegate methods
extension TrendingViewController: TrendingViewProtocol {
    func showRecipeImageLoading(_ loading: Bool, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.trendingView.trendingCollection.cellForItem(at: indexPath) as? TrendingViewCell {
                cell.showLoading(loading)
            }
        }
    }
    
    func didUpdateRecipeImage(_ imageData: Data, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.trendingView.trendingCollection.cellForItem(at: indexPath) as? TrendingViewCell {
                cell.updateRecipeImage(with: imageData)
            }
        }
    }
}

// MARK: - Collection Cell Delegate methods
extension TrendingViewController: TrendingViewCellProtocol {
    func saveRecipe(at indexPath: IndexPath, imageData: Data) {
        let selectedRecipe = presenter.getRecipes[indexPath.row]
        var isRecipeSaved = presenter.isRecipeSaved(at: indexPath.row)
        
        if !isRecipeSaved {
            presenter.saveRecipe(recipe: selectedRecipe, imageData: imageData)
        } else {
            presenter.deleteRecipe(recipe: selectedRecipe)
        }
        
        presenter.toggleSaveState(at: indexPath.row)
        isRecipeSaved = presenter.isRecipeSaved(at: indexPath.row)
        
        updateSaveButtonImage(at: indexPath, isRecipeSaved: isRecipeSaved)
    }
    
    private func updateSaveButtonImage(at indexPath: IndexPath, isRecipeSaved: Bool) {
        guard let cell = trendingView.trendingCollection.cellForItem(at: indexPath) as? TrendingViewCell else {
            return
        }
        cell.updateSaveButtonImage(isRecipeSaved: isRecipeSaved)
    }
    
    func loadImage(for indexPath: IndexPath) {
        let recipe = presenter.getRecipes[indexPath.row]
        guard let imageUrl = recipe.imageURL else { return }
        
        presenter.loadRecipeImage(with: imageUrl, at: indexPath)
    }
}

// MARK: - CollectionView DataSource methods
extension TrendingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let recipesCount = presenter.getRecipes.count
        return recipesCount > 0 ? recipesCount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if presenter.getRecipes.isEmpty {
            return createEmptyCell(for: collectionView, at: indexPath)
        } else {
            return createRecipeCell(for: collectionView, at: indexPath)
        }
    }
    
    private func createEmptyCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.emptyCell, for: indexPath) as? EmptyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        emptyCell.configure(with: K.emptyTrendingText)
        return emptyCell
    }
    
    private func createRecipeCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.trendingCell, for: indexPath) as? TrendingViewCell else {
            return UICollectionViewCell()
        }
        
        let recipe = presenter.getRecipes[indexPath.row]
        let isRecipeSaved = presenter.isRecipeSaved(at: indexPath.row)
        let recipeMinutes = recipe.readyInMinutes ?? 0
        let strRecipeMinutes = formatMinutesToString(minutes: recipeMinutes)
        let cellConfig = TrendingCellConfiguration(
            title: recipe.title ?? "",
            rating: recipe.rating,
            recipeMinutes: strRecipeMinutes,
            authorName: recipe.author ?? "",
            isRecipeSaved: isRecipeSaved,
            indexPath: indexPath
        )
        
        cell.delegate = self
        cell.configure(with: cellConfig)
        return cell
    }
    
    private func formatMinutesToString(minutes: Int) -> String {
        let totalSeconds = minutes * 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - CollectionView Delegate methods
extension TrendingViewController: UICollectionViewDelegate {
    /// collection selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TrendingViewCell else {
            return
        }
        
        let selectedRecipe = presenter.getRecipes[indexPath.row]
        let recipeImageData = cell.recipeImageData
        presenter.showRecipeDetails(for: selectedRecipe, with: recipeImageData)
    }
}
