//
//  CreateRecipeTitleCell.swift
//  BestRecipes
//
//  Created by nik on 14.07.24.
//

import UIKit

protocol CreateRecipeTitleCellDelegate: AnyObject {
    func didTapButton(_ indexPath: IndexPath?, _ plusButton: Bool)
}

final class CreateRecipeTitleCell: UITableViewCell {
    static let identifier = "CreateRecipeTitleCell"
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeTitle = createTextField("Recipe title")
    
    weak var delegate: CreateRecipeTitleCellDelegate?
    
    var cellIndexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstrains()
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
        field.layer.borderColor = UIColor.redBase.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 8.0
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addSubviews(recipeTitle)
        contentView.addSubviews(container)
        addSubviews(container)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            recipeTitle.topAnchor.constraint(equalTo: container.topAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            recipeTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            recipeTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
