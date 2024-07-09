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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
