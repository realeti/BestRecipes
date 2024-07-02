//
//  BRFavoritesButton.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class BRFavoritesButton: UIButton {
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        changeState()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Internal Methods

private extension BRFavoritesButton {
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 16
        tintColor = .redLight
        setImage(.bookmarkInactive, for: .normal)
        configuration = UIButton.Configuration.plain()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func changeState() {
        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            switch button.state {
            case.highlighted:
                tintColor = .redLight
            default:
                tintColor = .greyLight
            }
        }
    }
}
