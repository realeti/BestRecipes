//
//  CreateRecipeIngredientCell.swift
//  BestRecipes
//
//  Created by nik on 12.07.24.
//

import UIKit

protocol CreateRecipeIngredientCellDelegate: AnyObject {
    func didTapButton(_ indexPath: IndexPath?, _ plusButton: Bool)
}

final class CreateRecipeIngredientCell: UITableViewCell {
    static let identifier = "IngredientCell"
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ingredientName = createTextField("name")
    
    private lazy var ingredientWeight = createTextField("weight")
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus-Border"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: CreateRecipeIngredientCellDelegate?
    
    var cellIndexPath: IndexPath?
    
    private var plusButton = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstrains()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTextField(_ placeholder: String) -> UITextField {
        let field = UITextField()
        field.font = Font.getFont(.poppinsRegular, size: 14)
        field.placeholder = placeholder
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.layer.borderColor = UIColor.greyBorder.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 8.0
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
    
    @objc func buttonTapped() {
        delegate?.didTapButton(cellIndexPath, plusButton)
        plusButton
            ? button.setImage(UIImage(named: "Minus-Border"), for: .normal)
            : button.setImage(UIImage(named: "Plus-Border"), for: .normal)
        plusButton.toggle()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addSubviews(ingredientName, ingredientWeight, button)
        contentView.addSubviews(container)
        addSubviews(container)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            ingredientName.topAnchor.constraint(equalTo: container.topAnchor),
            ingredientName.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            ingredientName.trailingAnchor.constraint(equalTo: container.centerXAnchor, constant: -8),
            ingredientName.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            ingredientWeight.topAnchor.constraint(equalTo: container.topAnchor),
            ingredientWeight.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: 8),
            ingredientWeight.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -18),
            ingredientWeight.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 21),
            button.widthAnchor.constraint(equalToConstant: 21),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18),
            
        ])
    }
    
    private func setupActions() {
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }
}
