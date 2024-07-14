//
//  LastPageViewController.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit


class LastPageViewController: UIViewController {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .thirdOnboarding)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var textLabelView: UILabel = {
        let label = UILabel()
        label.text = "Cook it now or"
        label.font = UIFont(name: "Poppins-Bold", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var textLabelGreenView: UILabel = {
        let label = UILabel()
        label.text = "save it for later"
        label.font = UIFont(name: "Poppins-Bold", size: 40)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var pageIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        return view
    }()
    
    private lazy var pageIndicatorNon: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        return view
    }()
    
    private lazy var pageIndicatorNon1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        return view
    }()
    
    private lazy var stackIndicator: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    private lazy var continuesButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .red
        button.setTitle("Start Cooking", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupUI()
        
        constraintsUI()
        
        continuesButton.addTarget(self, action: #selector(setMainView), for: .touchUpInside)
    }
    
    @objc func setMainView() {
        UserDefaults.standard.set(true, forKey: "SegueMainVCCompleted")
    }
    
}

private extension LastPageViewController{
        
        func setupUI(){
            view.addSubview(backView)
            backView.addSubviews(backgroundImageView ,overlayView, textLabelView, textLabelGreenView, stackIndicator, continuesButton)
            stackIndicator.addArrangedSubviews([pageIndicator, pageIndicatorNon, pageIndicatorNon1])
        }
        
        func constraintsUI() {
            NSLayoutConstraint.activate([
                
                backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backView.topAnchor.constraint(equalTo: view.topAnchor),
                backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                backgroundImageView.topAnchor.constraint(equalTo: backView.topAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            
                overlayView.topAnchor.constraint(equalTo: backView.topAnchor),
                overlayView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
                overlayView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
                
                textLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                textLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                textLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 540),
                
                textLabelGreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                textLabelGreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                textLabelGreenView.topAnchor.constraint(equalTo: textLabelView.bottomAnchor, constant: 1),
                
                stackIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackIndicator.topAnchor.constraint(equalTo: textLabelGreenView.bottomAnchor, constant: 30),
                stackIndicator.heightAnchor.constraint(equalToConstant: 10),
                
                continuesButton.topAnchor.constraint(equalTo: stackIndicator.bottomAnchor, constant: 20),
                continuesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                continuesButton.heightAnchor.constraint(equalToConstant: 40),
                continuesButton.widthAnchor.constraint(equalToConstant: 240),
            ])
        }
        
}

