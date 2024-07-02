//
//  MainViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var searchTextField: UITextField = {
        $0.placeholder = "Search recipe"
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.greyBorder.cgColor
        $0.layer.borderWidth = 1
        $0.textColor = .greyLight
        $0.font = Font.getFont(.poppinsRegular, size: 14)
        $0.tintColor = .greyBase
        $0.setupLeftImage()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private let collectionView = BRCollectionView()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
    }
}


//MARK: - Internal Methods

private extension MainViewController {
    func configure() {
        view.backgroundColor = .white
        view.addSubviews(searchTextField, collectionView)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchTextField.heightAnchor.constraint(equalToConstant: 45),
        
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
