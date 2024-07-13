//
//  CreateRecipeIngredientCell.swift
//  BestRecipes
//
//  Created by nik on 12.07.24.
//

import UIKit

final class CreateRecipeIngredientCell: UITableViewCell {
    static let identifier = "IngredientCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .blue
        
        stack.axis = .horizontal
        stack.spacing = 3
        stack.alignment = .center
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lable1: UILabel = {
        let label = UILabel()
        label.text = "LABEL 1"
        label.font = .systemFont(ofSize: 30)
        label.backgroundColor = .red
        return label
    }()
    
    private let lable2: UILabel = {
        let label = UILabel()
        label.text = "LABEL 2"
        label.font = .systemFont(ofSize: 30)
        label.backgroundColor = .yellow
        return label
    }()
    
    private let lable3: UILabel = {
        let label = UILabel()
        label.text = "LABEL 3"
        label.font = .systemFont(ofSize: 30)
        label.backgroundColor = .green
        return label
    }()
    
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubviews(lable1, lable2, lable3)
        containerView.addSubview(stackView)
        
        addSubviews(containerView)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 1),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            //containerView.heightAnchor.constraint(equalToConstant: 200),
            //containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}










import SwiftUI

struct CreateRecipeIngredientCellProvider: PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: CreateRecipeViewController()).preview()
        }
    }
}
