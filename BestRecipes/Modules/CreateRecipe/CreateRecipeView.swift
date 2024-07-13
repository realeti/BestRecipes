//
//  CreateRecipeView.swift
//  BestRecipes
//
//  Created by nik on 09.07.24.
//

import UIKit

protocol CreateRecipeViewDelegate: AnyObject {
    func createRecipeButtonPressed()
}

class CreateRecipeView: UIView {
    
    //MARK: - Dependencies
    weak var delegate: CreateRecipeViewDelegate?
    
    //MARK: - Private properties
    private lazy var tableView = makeTableView()
    
    
    private let createRecipeButtom: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstrains()
        setupTargetAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setupConstrains()
        setupTargetAction()
    }
    
    private func makeTableView() -> UITableView {
        let element = UITableView()
        
        element.dataSource = self
        element.delegate = self
        element.register(
            CreateRecipeIngredientCell.self,
            forCellReuseIdentifier: CreateRecipeIngredientCell.identifier
        )
        element.translatesAutoresizingMaskIntoConstraints = false
        
        return element
    }
    
}

//MARK: - Selectors
private extension CreateRecipeView {
    @objc func createRecipeButtonClicked() {
        delegate?.createRecipeButtonPressed()
    }
}

//MARK: - Setup UI
private extension CreateRecipeView {
    func setViews() {
        addSubviews(
            tableView,
            createRecipeButtom
        )
    }
    
    func setupTargetAction() {
        createRecipeButtom.addTarget(
            self,
            action: #selector(createRecipeButtonClicked),
            for: .touchUpInside
        )
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            createRecipeButtom.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 13),
            createRecipeButtom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createRecipeButtom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            createRecipeButtom.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

// MARK: - TableViewDataSource
extension CreateRecipeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Section №\(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 4 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CreateRecipeIngredientCell.identifier,
            for: indexPath
        ) as? CreateRecipeIngredientCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension CreateRecipeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                200
            case 1:
                45
            default:
                60
            }
        } else {
            45
        }
    }
}










import SwiftUI

extension UIViewController {
    struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    func preview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}

struct CreateRecipeProvider: PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: CreateRecipeViewController()).preview()
        }
    }
}
