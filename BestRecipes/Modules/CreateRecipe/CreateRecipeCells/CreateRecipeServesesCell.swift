//
//  CreateRecipeServesesCell.swift
//  BestRecipes
//
//  Created by nik on 13.07.24.
//

import UIKit

protocol CreateRecipeServesesCellDelegate: AnyObject {
    func didTapServesesButton(_ indexPath: IndexPath?)
}

final class CreateRecipeServesesCell: UITableViewCell {
    static let identifier = "ServesesCell"
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .greyBorder
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellImageConteiner: UIView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var  cellImageView: UIImageView = {
        
        let view = UIImageView()
        view.image = UIImage(named: "Profile") ?? UIImage()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Serves"
        label.font = Font.getFont(.poppinsSemiBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var servesCount: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.font = Font.getFont(.poppinsRegular, size: 16)
        label.textAlignment = .right
        label.textColor = .greyBase
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Arrow-Right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: CreateRecipeServesesCellDelegate?
    
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
    
    override func prepareForReuse() {
        button.setImage(UIImage(named: "Plus-Border"), for: .normal)
        plusButton = true
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
        delegate?.didTapServesesButton(cellIndexPath)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        cellImageConteiner.addSubview(cellImageView)
        container.addSubviews(cellImageConteiner, cellLabel, servesCount, button)
        
        contentView.addSubviews(container)
        addSubviews(container)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            cellImageConteiner.heightAnchor.constraint(equalToConstant: 36),
            cellImageConteiner.widthAnchor.constraint(equalToConstant: 36),
            cellImageConteiner.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            cellImageConteiner.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            
            cellImageView.heightAnchor.constraint(equalToConstant: 20),
            cellImageView.heightAnchor.constraint(equalToConstant: 20),
            cellImageView.centerXAnchor.constraint(equalTo: cellImageConteiner.centerXAnchor),
            cellImageView.centerYAnchor.constraint(equalTo: cellImageConteiner.centerYAnchor),
            
            cellLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageConteiner.trailingAnchor, constant: 16),
            
            servesCount.topAnchor.constraint(equalTo: container.topAnchor),
            servesCount.leadingAnchor.constraint(equalTo: container.centerXAnchor, constant: 8),
            servesCount.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -18),
            servesCount.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
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

