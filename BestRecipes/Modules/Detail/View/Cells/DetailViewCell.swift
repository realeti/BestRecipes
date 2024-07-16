//
//  DetailViewCell.swift
//  BestRecipes
//
//  Created by realet on 16.07.2024.
//

import UIKit

protocol DetailViewCellProtocol: AnyObject {
    func loadIngredientImage(for cell: DetailViewCell, at indexPath: IndexPath)
}

final class DetailViewCell: UITableViewCell {
    // MARK: - UI
    private let baseView = UIView(
        backgroundColor: .greyLighter,
        cornerRadius: 12.0
    )
    
    private let mainStack = UIStackView(
        axis: .horizontal,
        spacing: 16.0,
        distribution: .fill
    )
    
    let ingredientImageView = UIImageView(
        backgroundColor: .white,
        contentMode: .scaleAspectFit,
        cornerRadius: 8.0
    )
    
    private let ingredientNameLabel = UILabel(
        color: .blackBase,
        font: .poppinsBold,
        fontSize: 16.0
    )
    
    private let ingredientGramLabel = UILabel(
        color: .greyBase,
        font: .poppinsRegular,
        fontSize: 14.0
    )
    
    private lazy var spacerView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Public Properties
    weak var delegate: DetailViewCellProtocol?
    var indexPath: IndexPath?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        ingredientImageView.image = nil
        ingredientNameLabel.text = nil
        ingredientGramLabel.text = nil
    }
    
    // MARK: - Set Views
    private func setupUI() {
        contentView.addSubview(baseView)
        baseView.addSubview(mainStack)
        
        mainStack.addArrangedSubviews(
            ingredientImageView,
            ingredientNameLabel,
            ingredientGramLabel
        )
    }
}

// MARK: - Configure UI
extension DetailViewCell {
    private func configureUI() {
        contentView.backgroundColor = .white
    }
}

// MARK: - Configure Cell
extension DetailViewCell {
    func configure(name: String, amount: Double, indexPath: IndexPath) {
        self.indexPath = indexPath
        ingredientNameLabel.text = name
        ingredientGramLabel.text = "\(amount)g"
        setupMockIngredientImage(at: indexPath)
        //delegate?.loadIngredientImage(for: self, at: indexPath)
    }
    
    private func setupMockIngredientImage(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ingredientImageView.image = .fish
        case 1:
            ingredientImageView.image = .ginger
        case 2:
            ingredientImageView.image = .sunflowerOil
        case 3:
            ingredientImageView.image = .salt
        case 4:
            ingredientImageView.image = .cucumber
        default:
            ingredientImageView.image = .noimage
        }
    }
}

// MARK: - Setup Constraints
extension DetailViewCell {
    private func setupConstraints() {
        setupBaseViewConstraints()
        setupMainStackConstraints()
        setupIngredientImageViewConstraints()
    }
    
    private func setupBaseViewConstraints() {
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
        ])
    }
    
    private func setupMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -12),
        ])
    }
    
    private func setupIngredientImageViewConstraints() {
        NSLayoutConstraint.activate([
            ingredientImageView.widthAnchor.constraint(equalToConstant: 50),
            ingredientImageView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
