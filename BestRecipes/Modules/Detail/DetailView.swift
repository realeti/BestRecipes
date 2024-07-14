//
//  DetailView.swift
//  BestRecipes
//
//  Created by Pavel Kostin on 13.07.2024.
//


import UIKit

final class DetailView: UIView {
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let mainVerticalStack = UIStackView()
    private let topStack = UIStackView()
    private let bottomStack = UIStackView()
    
    private let topLabel = UILabel()
    
    private let imageFood = UIImageView()
    
    private let starImage = UIImageView()
    private let rateLabel = UILabel()
    private let reviewsLabel = UILabel()
    private let spacerView = UIView()
    
    private var ingredients: [DetailIngredient] = []
    
    private let detailTextView = DetailText()
    
    private let tableView = DetailTableView()
    
    private var heightTableViewConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setupView()
        setupConstraint()
        setupConfigure()
        updateTableView()
        tableView.tableViewData = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}



private extension DetailView {
    
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([topLabel, mainVerticalStack, detailTextView, tableView])
        mainVerticalStack.addArrangedSubviews([topStack, bottomStack])
        topStack.addArrangedSubviews([imageFood])
        bottomStack.addArrangedSubviews([starImage, rateLabel, reviewsLabel, spacerView])
    }
    
    func setupConstraint() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            topLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            
            mainVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainVerticalStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 16),
            
            detailTextView.topAnchor.constraint(equalTo: mainVerticalStack.bottomAnchor, constant: 15),
            detailTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: detailTextView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        heightTableViewConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        heightTableViewConstraint?.isActive = true
    }
    
    func setupConfigure() {
        
        backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = false
        
        mainVerticalStack.axis = .vertical
        mainVerticalStack.spacing = 16
        
        topStack.axis = .vertical
        topStack.spacing = 16
        
        topLabel.font = Font.getFont(.poppinsBold, size: 24)
        topLabel.numberOfLines = 0
        
        imageFood.contentMode = .scaleToFill
        
        bottomStack.spacing = 5
        bottomStack.contentMode = .scaleAspectFit
        
        bottomStack.axis = .horizontal
        
        starImage.image = UIImage(named: "star")
        starImage.contentMode = .scaleAspectFit
        
        rateLabel.font = Font.getFont(.poppinsBold, size: 14)
        
        reviewsLabel.font = Font.getFont(.poppinsRegular, size: 14)
        reviewsLabel.textColor = #colorLiteral(red: 0.6358334422, green: 0.6358334422, blue: 0.6358334422, alpha: 1)
    }
}

extension DetailView {
    
    func updateTableView() {
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.heightTableViewConstraint?.constant = self.tableView.contentSize.height
        self.layoutIfNeeded()
    }
}


extension DetailView: DetailViewProtocol {
    func setTitle(_ title: String) {
        topLabel.text = title
    }

    func setImage(url: String) {
      // метод для получения image
//        imageFood.loadImage1(from: url)
    }

    func setRatingText(_ text: String) {
        rateLabel.text = text
    }

    func setReviewsCount(_ count: String) {
        reviewsLabel.text = count
    }

    func setInstructions(_ instructions: [Step]) {
        detailTextView.updateInstructionText(with: instructions)
    }

    func updateIngredients(_ ingredients: [DetailIngredient]) {
        self.ingredients = ingredients
        updateTableView()
    }
}


extension DetailView: DetailTableViewData {
    func numberOfIngredients() -> Int {
        ingredients.count
    }
    
    func ingredient(at index: Int) -> DetailIngredient {
        ingredients[index]
    }
}

