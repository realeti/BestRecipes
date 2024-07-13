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
        button.setTitle("Create recipe", for: .normal)
        button.titleLabel?.font = Font.getFont(.poppinsRegular, size: 16)
        button.tintColor = .white
        button.backgroundColor = .redBase
        button.layer.cornerRadius = 8
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
        let table = UITableView()
        table.backgroundColor = .none
        table.separatorStyle = .none
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.register(
            CreateRecipeIngredientCell.self,
            forCellReuseIdentifier: CreateRecipeIngredientCell.identifier
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }
    
    private var ingredientCount = 1
    
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
            createRecipeButtom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createRecipeButtom.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

// MARK: - TableViewDataSource
extension CreateRecipeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return UIView() }
        
        let header = UIView()
        let label = UILabel()
        label.text = "Ingredients"
        label.font = Font.getFont(.poppinsSemiBold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 4 : ingredientCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CreateRecipeIngredientCell.identifier,
            for: indexPath
        ) as? CreateRecipeIngredientCell else { return UITableViewCell() }
        cell.cellIndexPath = indexPath
        cell.delegate = self
        
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
            45 + 16
        }
    }
}

//MARK: - CreateRecipeIngredientCellDelegate
extension CreateRecipeView: CreateRecipeIngredientCellDelegate {
    func didTapButton(_ indexPath: IndexPath?, _ plusButton: Bool) {
        guard let targetSection = indexPath?.section,
              let targetRow = indexPath?.row else { return }
        if plusButton {
            ingredientCount += 1
            tableView.insertRows(at: [[targetSection, targetRow + 1]], with: .automatic)
        } else {
            ingredientCount -= 1
            tableView.deleteRows(at: [[targetSection, targetRow]], with: .automatic)
        }
        
        updateIndexses()
    }
}

extension CreateRecipeView {
    func updateIndexses() {
        for row in 0..<tableView.numberOfRows(inSection: 1) {
            let indexPath = IndexPath(row: row, section: 1)
            if let cell = tableView.cellForRow(at: indexPath) {
                guard let customCell = cell as? CreateRecipeIngredientCell else { return }
                customCell.cellIndexPath = [1, row]
                print(cell)
            }
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
