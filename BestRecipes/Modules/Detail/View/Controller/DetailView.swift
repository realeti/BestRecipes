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
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let baseStackView = UIStackView(
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
    
    private let reviesSpacerView = UIView()
    
    lazy var detailTextView: DetailText = {
        let view = DetailText()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: K.detailHeaderView)
        view.register(DetailViewCell.self, forCellReuseIdentifier: K.detailTableCell)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var ingredients: [DetailIngredient] = []
    private var heightTableViewConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: .zero)
        backgroundColor = .white
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Set Views
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(baseStackView)
        
        baseStackView.addArrangedSubviews(
            topLabel,
            imageFood,
            ratingStackView
        )
        
        ratingStackView.addArrangedSubviews(
            starImage,
            rateLabel,
            rateSpacerView,
            reviewsLabel,
            reviesSpacerView
        )
        
        contentView.addSubviews(detailTextView, tableView)
    }
}

// MARK: - Setup Constraints
private extension DetailView {
    func setupConstraint() {
        setupScollViewConstraints()
        setupContentViewConstraints()
        setupTopStackViewConstraints()
        setupImageFoodConstraints()
        setupStarImageConstraints()
        setupRateSpacerViewConstraints()
        setupDetailTextViewConstraints()
        setupIngredientsTableConstraints()
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
            baseStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2.0),
            baseStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: baseStackView.trailingAnchor, multiplier: 2.0).withPriority(.defaultHigh)
        ])
    }
    
    func setupImageFoodConstraints() {
        NSLayoutConstraint.activate([
            imageFood.widthAnchor.constraint(equalTo: baseStackView.widthAnchor),
            imageFood.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.52)
        ])
    }
    
    func setupStarImageConstraints() {
        NSLayoutConstraint.activate([
            starImage.widthAnchor.constraint(equalToConstant: Metrics.ratingIconSize),
            starImage.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
    
    func setupRateSpacerViewConstraints() {
        NSLayoutConstraint.activate([
            rateSpacerView.widthAnchor.constraint(equalToConstant: 4.0),
            rateSpacerView.heightAnchor.constraint(equalToConstant: Metrics.ratingIconSize)
        ])
    }
    
    func setupDetailTextViewConstraints() {
        NSLayoutConstraint.activate([
            detailTextView.topAnchor.constraint(equalToSystemSpacingBelow: baseStackView.bottomAnchor, multiplier: 2.0),
            detailTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: detailTextView.trailingAnchor, multiplier: 3.0).withPriority(.defaultHigh)
        ])
    }
    
    func setupIngredientsTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1.0)
        ])
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

fileprivate struct Metrics {
    static let ratingIconSize: CGFloat = 16.0
}
