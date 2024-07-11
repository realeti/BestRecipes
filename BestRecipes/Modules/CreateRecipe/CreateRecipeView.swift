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

final class CreateRecipeView: UIView {
    
    //MARK: - Dependencies
    weak var delegate: CreateRecipeViewDelegate?
    
    //MARK: - Private properties
    private let centralLabel: UILabel = {
        let label = UILabel()
        label.text = "HI"
        return label
    }()
    
    private let createRecipeButtom: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
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
            centralLabel
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
            centralLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            centralLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            createRecipeButtom.topAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            createRecipeButtom.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
