//
//  SearchViewController.swift
//  BestRecipes
//
//  Created by realeti on 08.07.2024.
//

import UIKit

final class SearchViewController: UIViewController, SearchViewProtocol {
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

// MARK: - Presenter Delegate methods
extension SearchViewController {
    func showLoading(_ loading: Bool) {
        headerView?.showLoading(loading)
    }
    
    func didUpdateRecipes() {
        DispatchQueue.main.async {
            self.searchView.recipeCollection.reloadData()
        }
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
        return presenter.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.searchCell, for: indexPath) as? SearchViewCell else {
            return UICollectionViewCell()
        }
        
        let title = presenter.recipes[indexPath.row].title ?? ""
        let ingredientsCount = presenter.recipes[indexPath.row].extendedIngredients?.count ?? 0
        let recipeMinutes = presenter.recipes[indexPath.row].readyInMinutes ?? 0
        cell.configure(title, ingredientsCount, recipeMinutes)
        return cell
    }
}

// MARK: - CollectionView Delegate methods
extension SearchViewController: UICollectionViewDelegate {
    /// collection selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell #\(indexPath.row)")
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
        headerView?.searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func cancelButtonPressed(_ sender: UIButton) {
        presenter.backToHome()
    }
    
    @objc private func textDidChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty, text.count > 2 else {
            return
        }
        self.presenter.recipeSearch(with: text)
    }
    
    @objc private func hideKeyboard() {
        headerView?.searchTextField.endEditing(true)
    }
}
