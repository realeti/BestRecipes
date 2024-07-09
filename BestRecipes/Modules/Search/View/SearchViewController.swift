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
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        searchView = SearchView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActions()
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

// MARK: - Actions
extension SearchViewController {
    private func setActions() {
        searchView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchView.searchCancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func searchButtonPressed(_ sender: UIButton) {
        print("searchButton Click")
        searchView.searchTextField.endEditing(true)
    }
    
    @objc private func cancelButtonPressed(_ sender: UIButton) {
        print("cancelButton Click")
    }
    
    @objc private func textDidChange(textField: UITextField) {
        let searchText = textField.text ?? ""
        print(searchText)
    }
    
    @objc private func hideKeyboard() {
        searchView.searchTextField.endEditing(true)
    }
}

// MARK: - Set Delegates
extension SearchViewController {
    private func setDelegates() {
        searchView.searchTextField.delegate = self
    }
}

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    /// if pressed return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchView.searchTextField.endEditing(true)
        return true
    }
    
    /// if the text is empty, we don't process anything
   /* func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty ?? false) {
            return true
        } else {
            //textField.placeholder = K.searchPlaceholer
            return false
        }
    }*/
    
    /// if end editing was called
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let recipe = searchView.searchTextField.text {
            /// fetch data
        }
        //searchView.searchTextField.text = ""
    }
}
