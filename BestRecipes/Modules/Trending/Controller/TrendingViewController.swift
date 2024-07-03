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
    
    private lazy var button = BRFavoritesButton()
    
    var presenter: TrendingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trending now"
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .yellow
        view.addSubview(button)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 200).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    @objc func didTap() {
        presenter?.backTap()
        print("router pop to root")
    }
}
