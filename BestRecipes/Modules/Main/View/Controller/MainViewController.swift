//
//  MainViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
//    func searchTextFieldDidTap()
}


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
    
    private var collectionView = BRCollectionView()
    
    
    //MARK: - Properties
    
    var presenter: MainPresenterProtocol?
    public let sections = BRMockData.shared.pageData
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configure()
        setConstraints()
//        setupActions()
    }
    
    
    func configureCollectionView() {
        collectionView = BRCollectionView(presenterDelegate: presenter!)
    }
}


//MARK: - Actions

extension MainViewController: MainViewProtocol {
//    @objc func searchTextFieldDidTap() {
//        delelgate?.searchTextFieldTap()
//        searchTextField.endEditing(true)
//    }
}


//MARK: - Internal Methods

private extension MainViewController {
    
    //MARK: - Setup UI
    
    func configure() {
        view.backgroundColor = .white
        view.addSubviews(searchTextField, collectionView)
    }
    
    
//    func setupActions() {
//        searchTextField.addTarget(self, action: #selector(searchTextFieldDidTap), for: .editingDidBegin)
//    }
    
    
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
