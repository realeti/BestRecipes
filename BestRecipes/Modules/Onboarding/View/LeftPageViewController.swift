//
//  LeftPageViewController.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit

protocol LeftPageDelegate: AnyObject {
    func getNextController()
}

class LeftPageViewController: UIViewController{
    
    var presenter: OnboardingCollectionDelegate?
    private var onBoardingPresenter: OnBoardingCollectionViewPresenter?
    
    
    
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView(frame: view.bounds)
        image.image = .firstOnboarding
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
        label.font = UIFont(name: "Poppins-Bold", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
//
//    private lazy var textLabelGreenView: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.font = UIFont(name: "Poppins-Bold", size: 40)
//        label.textColor = .systemGreen
//        label.textAlignment = .center
//        label.numberOfLines = 1
//        return label
//    }()
    
    private lazy var pageIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
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
        view.backgroundColor = .gray
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
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 10)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let whiteText = "Recipes from all "
        let secondAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let firstAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemGreen]
        
        let labelTextWhite = NSMutableAttributedString(string: whiteText, attributes: secondAttributes)
        let labelTextGreen = NSMutableAttributedString(string: "over the World", attributes: firstAttributes)
        
        let combinensString = NSMutableAttributedString()
        combinensString.append(labelTextWhite)
        combinensString.append(labelTextGreen)
        
        textLabelView.attributedText = combinensString
        
        
        
        setupUI()
        
        constraintsUI()
        
        continuesButton.addTarget(self, action: #selector(getNextController), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipOnMainVC), for: .touchUpInside)
    }
    
    @objc func skipOnMainVC() {
        print("123")
    }
    
    @objc func getNextController(){
        if let onBoardingCollectionViewController = (self.parent as? OnboardingCollectionView?) {
            onBoardingCollectionViewController?.goToTheNextPage()
        }
    }
}


private extension LeftPageViewController{
    
    func setupUI(){
        view.addSubview(backView)
        backView.addSubviews(backgroundImageView, overlayView, textLabelView, stackIndicator, continuesButton, skipButton)
        stackIndicator.addArrangedSubviews([pageIndicator, pageIndicatorNon, pageIndicatorNon1])
    }
    
    func constraintsUI() {
        NSLayoutConstraint.activate([
            
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: backView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: backView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            
            textLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            
            stackIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackIndicator.topAnchor.constraint(equalTo: textLabelView.bottomAnchor, constant: 30),
            stackIndicator.heightAnchor.constraint(equalToConstant: 10),
            
            continuesButton.topAnchor.constraint(equalTo: stackIndicator.bottomAnchor, constant: 20),
            continuesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continuesButton.heightAnchor.constraint(equalToConstant: 45),
            continuesButton.widthAnchor.constraint(equalToConstant: 200),
            
            skipButton.topAnchor.constraint(equalTo: continuesButton.bottomAnchor, constant: 5),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 20),
            skipButton.widthAnchor.constraint(equalToConstant: 200),
            
            
        ])
    }
    
}

