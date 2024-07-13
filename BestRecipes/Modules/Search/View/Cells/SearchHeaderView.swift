//
//  SearchHeaderView.swift
//  BestRecipes
//
//  Created by realeti on 10.07.2024.
//

import UIKit

class SearchHeaderView: UICollectionReusableView {
    // MARK: - UI
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 8)
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.redBase.cgColor
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let searchIcon = UIImageView(
        image: .search,
        contentMode: .scaleAspectFit
    )
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        let textFieldFont = Font.getFont(.poppinsRegular, size: 14.0)
        textField.backgroundColor = .clear
        textField.textColor = .blackBase
        textField.tintColor = .blackBase
        textField.font = textFieldFont
        let attributes = [NSAttributedString.Key.font: textFieldFont]
        let attributedPlaceholder = NSAttributedString(string: K.searchPlaceholer, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchCancelButton = UIButton(
        backgroundImage: .plus,
        transform: CGAffineTransform(rotationAngle: .pi / 4)
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(searchStackView)
        searchStackView.addArrangedSubviews(searchIcon, activityIndicator, searchTextField, searchCancelButton)
    }
    
    // MARK: - Show Loading indicator
    func showLoading(_ loading: Bool) {
        if loading {
            self.searchIcon.isHidden = true
            self.activityIndicator.startAnimating()
        } else {
            self.searchIcon.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Setup Constraints
extension SearchHeaderView {
    private func setupConstraints() {
        setupSearchStackConstraints()
        setupSearchIconsConstraints()
    }
    
    private func setupSearchStackConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: searchStackView.trailingAnchor, multiplier: 1.0)
        ])
    }
    
    private func setupSearchIconsConstraints() {
        NSLayoutConstraint.activate([
            searchIcon.heightAnchor.constraint(equalToConstant: Metrics.iconSizes),
            searchIcon.widthAnchor.constraint(equalToConstant: Metrics.iconSizes),
            searchCancelButton.heightAnchor.constraint(equalToConstant: Metrics.iconSizes),
            searchCancelButton.widthAnchor.constraint(equalToConstant: Metrics.iconSizes),
            
            activityIndicator.centerYAnchor.constraint(equalTo: searchIcon.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: searchIcon.centerXAnchor)
        ])
    }
}

fileprivate struct Metrics {
    static let iconSizes: CGFloat = 20.0
}
