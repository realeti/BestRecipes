//
//  DetailView.swift
//  BestRecipes
//
//  Created by Pavel Kostin & realeti on 13.07.2024.
//


import UIKit

final class DetailView: UIView {
    // MARK: - UI
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topStackView = UIStackView(
        axis: .vertical,
        spacing: 16,
        distribution: .fill
    )
    
    let topLabel = UILabel(
        color: .black,
        font: .poppinsBold,
        fontSize: 24.0,
        numberOfLines: 2
    )
    
    let imageFood = UIImageView(
        contentMode: .scaleAspectFill,
        cornerRadius: 12
    )
    
    private let ratingStackView = UIStackView(
        axis: .horizontal,
        spacing: 3,
        distribution: .fill
    )
    
    private let starImage = UIImageView(
        image: .star,
        contentMode: .scaleAspectFit
    )
    
    let rateLabel = UILabel(
        color: .black,
        font: .poppinsBold,
        fontSize: 14.0
    )
    
    private lazy var rateSpacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reviewsLabel = UILabel(
        color: .greyBase,
        font: .poppinsRegular,
        fontSize: 14.0
    )
    
    private let spacerView = UIView()
    
    private let mainVerticalStack = UIStackView()
    private let bottomStack = UIStackView()
    
    var ingredients: [DetailIngredient] = []
    
    let detailTextView = DetailText()
    
    private let tableView = DetailTableView()
    
    private var heightTableViewConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: .zero)
        backgroundColor = .white
        
        setupView()
        setupConstraint()
        setupConfigure()
        updateTableView()
        tableView.tableViewData = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Set Views
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topStackView)
        topStackView.addArrangedSubviews(topLabel, imageFood, ratingStackView)
        ratingStackView.addArrangedSubviews(starImage, rateLabel, rateSpacerView, reviewsLabel, spacerView)
        //contentView.addSubviews([/*, mainVerticalStack,*/ /*detailTextView, tableView*/])
        //mainVerticalStack.addArrangedSubviews(/*, bottomStack*/])
        //bottomStack.addArrangedSubviews([starImage, rateLabel, reviewsLabel, spacerView])
    }
}

// MARK: - Setup Constraints
private extension DetailView {
    func setupConstraint() {
        mainVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setupScollViewConstraints()
        setupContentViewConstraints()
        setupTopStackViewConstraints()
        setupImageFoodConstraints()
        setupStarImageConstraints()
        setupRateSpacerViewConstraints()
        
        NSLayoutConstraint.activate([

            /*mainVerticalStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 16),
            mainVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),*/
            
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
    
    func setupScollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupTopStackViewConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).withPriority(.defaultHigh),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupImageFoodConstraints() {
        NSLayoutConstraint.activate([
            imageFood.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            imageFood.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.52)
        ])
    }
    
    func setupStarImageConstraints() {
        NSLayoutConstraint.activate([
            starImage.widthAnchor.constraint(equalToConstant: Metrics.ratingIconSize),
            starImage.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
    
    private func setupRateSpacerViewConstraints() {
        NSLayoutConstraint.activate([
            rateSpacerView.widthAnchor.constraint(equalToConstant: 4.0),
            rateSpacerView.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
}



private extension DetailView {
    func setupConfigure() {
        
        mainVerticalStack.axis = .vertical
        mainVerticalStack.spacing = 16
        
        bottomStack.spacing = 5
        bottomStack.contentMode = .scaleAspectFit
        
        bottomStack.axis = .horizontal
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

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
}
