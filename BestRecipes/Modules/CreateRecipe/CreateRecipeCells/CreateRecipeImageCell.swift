//
//  CreateRecipeImageCell.swift
//  BestRecipes
//
//  Created by nik on 14.07.24.
//

import UIKit

protocol CreateRecipeImageCellDelegate: AnyObject {
    func didTapImageButton(_ indexPath: IndexPath?, _ plusButton: Bool)
}

final class CreateRecipeImageCell: UITableViewCell {
    static let identifier = "CreateRecipeImageCell"
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white        
        view.layer.borderColor = UIColor.greyBorder.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 12.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "noimage") ?? UIImage()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: CreateRecipeImageCellDelegate?
    
    var cellIndexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addSubviews(recipeImage)
        //contentView.addSubviews(container)
        addSubviews(container)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            recipeImage.topAnchor.constraint(equalTo: container.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

