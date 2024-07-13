//
//  TrendingViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

protocol TrendingViewProtocol: AnyObject {
    
}


final class TrendingViewController: UIViewController, TrendingViewProtocol {
    
    //MARK: - TEST router + presenter + builder
    
    var presenter: TrendingPresenterProtocol?
    
    
    
    
    private let tableView = TrendingTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trending now"
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
