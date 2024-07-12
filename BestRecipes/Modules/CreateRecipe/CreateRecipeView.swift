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
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createRecipeButtom: UIButton = {
        let button = UIButton(type: .system)
        //button.layer.cornerRadius = 1
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
            centralLabel,
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
            centralLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            centralLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            createRecipeButtom.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            createRecipeButtom.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
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
