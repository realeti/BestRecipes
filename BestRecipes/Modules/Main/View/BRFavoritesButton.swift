//
//  BRFavoritesButton.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRFavoritesButton: UIButton {
    
    //MARK: - Properties
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setImage(.favoritesActive, for: .selected)
            } else {
                setImage(.favoritesInactive, for: .normal)
            }
        }
    }
    
    weak var delegate: MainPresenterProtocol?
    
    
    //MARK: - Lifecycle
    
//    init(presenter: MainPresenterProtocol) {
//        self.delegate = presenter
//        super.init(frame: .zero)
//        
//        configure()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension BRFavoritesButton {
    @objc func favoritesButtonHandler() {
        if isSelected {
            delegate?.removeFromFavorites()
        } else {
            delegate?.addToFavorites()
        }
        self.isSelected.toggle()
    }
    
    
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 16
        setImage(.favoritesInactive, for: .normal)
        setImage(.favoritesInactive, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(favoritesButtonHandler), for: .touchUpInside)
    }
}
