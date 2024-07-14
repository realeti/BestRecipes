//
//  OnboardingViewController.swift
//  BestRecipes
//
//  Created by Drolllted on 14.07.2024.
//

import Foundation
import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func segueCollectionView()
}

class OnboardingViewController: UIViewController, OnboardingViewControllerDelegate {
    
    var presenter: OnboardingPresenterProtocol!
    
    private lazy var onBoardingImage: UIImageView = {
        let image = UIImageView()
        image.image = .homePage
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var layerProImage: UIImageView = {
        let image = UIImageView()
        image.image = .layerPro
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - create recipes label
    
    private lazy var starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .black
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var countLoadLabel: UILabel = {
        let label = UILabel()
        label.text = "100k"
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium Recipes"
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var premiumStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: - Create Labels name App and Discription
    
    private lazy var nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Recipe"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Bold", size: 56)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Find best recipes for cooking"
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackNamedAndDiscription: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: - Start button
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitle("Get startes", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(segueCollectionView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "OnBoardingCompleted")
        
        configure()
        
        setupUI()
        
        constraintsUI()
    }
    
    @objc func segueCollectionView() {
       // presenter.onTapButton()
        print("123")
    }
    
    
}

private extension OnboardingViewController {
    func configure() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        
    }
    
    func setupUI() {
        
        view.addSubviews(onBoardingImage, layerProImage ,starImage, premiumStack, stackNamedAndDiscription, startButton)
        premiumStack.addArrangedSubviews([countLoadLabel, premiumLabel])
        stackNamedAndDiscription.addArrangedSubviews([nameAppLabel, discriptionLabel])
        
    }
    
    func constraintsUI (){
        NSLayoutConstraint.activate([
            onBoardingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoardingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onBoardingImage.topAnchor.constraint(equalTo: view.topAnchor),
            onBoardingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            layerProImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layerProImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            layerProImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            layerProImage.topAnchor.constraint(equalTo: view.topAnchor),
            
            //MARK: - Star Image
            
            starImage.topAnchor.constraint(equalTo: onBoardingImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            starImage.leadingAnchor.constraint(equalTo: onBoardingImage.leadingAnchor, constant: 85),
            starImage.heightAnchor.constraint(equalToConstant: 18),
            starImage.widthAnchor.constraint(equalToConstant: 18),
            
            //MARK: - premium Load Stack
            
            premiumStack.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 5),
            premiumStack.topAnchor.constraint(equalTo: onBoardingImage.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            //MARK: - Named and Discription Label
            
            stackNamedAndDiscription.leadingAnchor.constraint(equalTo: onBoardingImage.leadingAnchor, constant: 35),
            stackNamedAndDiscription.trailingAnchor.constraint(equalTo: onBoardingImage.trailingAnchor, constant: -35),
            stackNamedAndDiscription.topAnchor.constraint(equalTo: premiumStack.bottomAnchor, constant: 420),
            
            //MARK: - Start Button
            
            startButton.leadingAnchor.constraint(equalTo: onBoardingImage.leadingAnchor, constant: 110),
            startButton.trailingAnchor.constraint(equalTo: onBoardingImage.trailingAnchor, constant: -110),
            startButton.topAnchor.constraint(equalTo: stackNamedAndDiscription.bottomAnchor, constant: 30),
            startButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
}
