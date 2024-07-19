//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: SearchViewPresenterProtocol!
    
    // MARK: - Private properties
    private var searchView: SearchView!
    private var headerView: SearchHeaderView?
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        searchView = SearchView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Setup TapGesture
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        searchView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Set Delegates
extension SearchViewController {
    private func setDelegates() {
        searchView.recipeCollection.dataSource = self
        searchView.recipeCollection.delegate = self
    }
    
    private func setHeaderViewDelegates() {
        headerView?.searchTextField.delegate = self
    }
}

// MARK: - Search Delegate methods
extension SearchViewController: SearchViewProtocol {
    func showSearchLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.headerView?.showLoading(loading)
        }
    }
    
    func showRecipeImageLoading(_ loading: Bool, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.searchView.recipeCollection.cellForItem(at: indexPath) as? SearchViewCell {
                cell.showLoading(loading)
            }
        }
    }
    
    func didUpdateRecipes() {
        DispatchQueue.main.async {
            self.searchView.recipeCollection.reloadData()
        }
    }
    
    func didUpdateRecipeImage(_ imageData: Data, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.searchView.recipeCollection.cellForItem(at: indexPath) as? SearchViewCell {
                cell.updateRecipeImage(with: imageData)
            }
        }
    }
}

// MARK: - Collection Cell Delegate methods
extension SearchViewController: SearchViewCellProtocol {
    func loadImage(for cell: SearchViewCell, at indexPath: IndexPath) {
        let recipe = presenter.getRecipes[indexPath.row]
        guard let imageUrl = recipe.imageURL else { return }
        
        presenter.loadRecipeImage(with: imageUrl, at: indexPath)
    }
}

// MARK: - TextField Delegate methods
extension SearchViewController: UITextFieldDelegate {
    /// if pressed return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        guard let text = textField.text, !text.isEmpty, text.count > 2 else {
            return true
        }
        
        presenter.recipeSearch(with: text)
        return true
    }
}

// MARK: - CollectionView DataSource methods
extension SearchViewController: UICollectionViewDataSource {
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
        
        emptyCell.configure(with: K.emptySearchText)
        return emptyCell
    }
    
    private func createRecipeCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.searchCell, for: indexPath) as? SearchViewCell else {
            return UICollectionViewCell()
        }
        
        let recipe = presenter.getRecipes[indexPath.row]
        let cellConfig = SearchCellConfiguration(
            rating: recipe.rating,
            title: recipe.title ?? "",
            ingredientsCount: recipe.extendedIngredients?.count ?? 0,
            recipeMinutes: recipe.readyInMinutes ?? 0,
            indexPath: indexPath
        )
        
        cell.delegate = self
        cell.configure(with: cellConfig)
        return cell
    }
}

// MARK: - CollectionView Delegate methods
extension SearchViewController: UICollectionViewDelegate {
    /// collection selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SearchViewCell else {
            return
        }
        
        let selectedRecipe = presenter.getRecipes[indexPath.row]
        let recipeImageData = cell.recipeImageData
        presenter.showRecipeDetails(for: selectedRecipe, with: recipeImageData)
    }
    
    /// collection header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: K.searchHeaderView, for: indexPath) as? SearchHeaderView else {
            return UICollectionReusableView()
        }
        
        headerView = header
        setHeaderViewDelegates()
        setHeaderViewActions()
        return header
    }
}

// MARK: - CollectionView FlowLayout Delegate methods
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    /// collection item  size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: collectionViewWidth * 0.58)
    }
    
    /// collection header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 64.0)
    }
}

// MARK: - Actions
extension SearchViewController {
    private func setHeaderViewActions() {
        headerView?.searchCancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        //headerView?.searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func cancelButtonPressed(_ sender: UIButton) {
        presenter.backToHome()
    }
    
    /*@objc private func textDidChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty, text.count > 2 else {
            return
        }
        self.presenter.recipeSearch(with: text)
    }*/
    
    @objc private func hideKeyboard() {
        headerView?.searchTextField.endEditing(true)
    }
}
