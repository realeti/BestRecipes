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
    
    let topLabel = UILabel(
        color: .black,
        font: .poppinsBold,
        fontSize: 24.0,
        numberOfLines: 2
    )
    let imageFood = UIImageView()
    private let starImage = UIImageView()
    let rateLabel = UILabel()
    let reviewsLabel = UILabel()
    private let spacerView = UIView()
    
    var ingredients: [DetailIngredient] = []
    
    let detailTextView = DetailText()
    
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
        contentView.addSubviews([topLabel, mainVerticalStack, /*detailTextView, tableView*/])
        mainVerticalStack.addArrangedSubviews([topStack, bottomStack])
        topStack.addArrangedSubviews([imageFood])
        bottomStack.addArrangedSubviews([starImage, rateLabel, reviewsLabel, spacerView])
    }
    
    func setupConstraint() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        imageFood.translatesAutoresizingMaskIntoConstraints = false
        starImage.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).withPriority(.defaultHigh),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).withPriority(.defaultHigh),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            mainVerticalStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 16),
            mainVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageFood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageFood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageFood.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.52),
            
            starImage.widthAnchor.constraint(equalToConstant: 16.0),
            starImage.heightAnchor.constraint(equalToConstant: 16.0),
            
            /*detailTextView.topAnchor.constraint(equalTo: mainVerticalStack.bottomAnchor, constant: 15),
            detailTextView.leadingAnchor.constraint(equalTo: imageFood.leadingAnchor),
            detailTextView.trailingAnchor.constraint(equalTo: imageFood.trailingAnchor),*/
            
            /*tableView.topAnchor.constraint(equalTo: detailTextView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),*/
        ])
        //heightTableViewConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        heightTableViewConstraint?.isActive = true
    }
    
    func setupConfigure() {
        
        backgroundColor = .white
        
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        
        mainVerticalStack.axis = .vertical
        mainVerticalStack.spacing = 16
        
        topStack.axis = .vertical
        topStack.spacing = 16
        
        topLabel.text = "How to make Tasty Fish (point & Kill)"
        
        imageFood.contentMode = .scaleToFill
        imageFood.layer.cornerRadius = 12
        imageFood.layer.masksToBounds = true
        
        bottomStack.spacing = 5
        bottomStack.contentMode = .scaleAspectFit
        
        bottomStack.axis = .horizontal
        
        starImage.image = UIImage(resource: .star)
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


extension DetailView: DetailTableViewData {
    func numberOfIngredients() -> Int {
        ingredients.count
    }
    
    func ingredient(at index: Int) -> DetailIngredient {
        ingredients[index]
    }
}

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
