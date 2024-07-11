//
//  MainViewController.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 30.06.2024.
//

import UIKit

//MARK: - MainViewProtocol

protocol MainViewProtocol: AnyObject {
    func render(sections: [BRSection])
    func addCategories(category: [BRCategoryModel])
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
    
    private var collectionView: BRCollectionView!
    
    
    //MARK: - Properties
    
    private let presenter: MainPresenterProtocol

    
    //MARK: - Lifecycle
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureCollectionView()
        configure()
        setConstraints()
//        presenter.fetchData()
    }
}


//MARK: - External Methods

extension MainViewController: MainViewProtocol {
    func render(sections: [BRSection]) {
        collectionView.updateContent(sections: sections)
    }
    
    
    func addCategories(category: [BRCategoryModel]) {
        collectionView.updateCategory(category: category)
        let defaultIndexPath = IndexPath(item: 0, section: 1)
        collectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: [])
    }
}


//MARK: - Internal Methods

private extension MainViewController {
    
    func configureCollectionView() {
        collectionView = BRCollectionView(presenter: presenter)
    }
    

    //MARK: - Setup UI
    
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
