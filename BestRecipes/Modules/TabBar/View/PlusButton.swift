//
//  PlusButton.swift
//  BestRecipes
//
//  Created by realeti on 01.07.2024.
//

import UIKit

final class PlusButton: UIButton {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - Private Methods
    private func configure() {
        setBackgroundImage(.plusButton, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
