//
//  BRSeeAllHeader.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRSeeAllHeader: UICollectionReusableView {
    
    //MARK: - UI
    
    private let titleLabel: UILabel = {
        $0.text = "Trending now 🔥"
        $0.textColor = .blackBase
        $0.textAlignment = .left
        $0.font = Font.getFont(.poppinsBold, size: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var seeAllButton: UIButton = {
        $0.setTitle("See all", for: .normal)
        $0.setTitleColor(.redLight, for: .normal)
        $0.setImage(.arrowRight.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.titleLabel?.font = Font.getFont(.poppinsBold, size: 14)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    
    //MARK: - Properties
    
    static let idHeader = "BRSeeAllHeader"
    weak var delegate: MainPresenterProtocol?
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        setCostraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension BRSeeAllHeader {
    func configureHeader(title: String, section: Int) {
        titleLabel.text = title
        seeAllButton.tag = section
        seeAllButton.addTarget(self, action: #selector(headerTapped), for: .touchUpInside)
    }
    
    
    @objc private func headerTapped(sender: UIButton) {
        delegate?.performActionForHeader(at: sender.tag)
    }
}


//MARK: - Internal Methods

private extension BRSeeAllHeader {
    func configure() {
        backgroundColor = .none
        addSubviews(titleLabel, seeAllButton)
    }
    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            seeAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllButton.heightAnchor.constraint(equalToConstant: 20),
            seeAllButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
