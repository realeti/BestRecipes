//
//  DetailCheckBox.swift
//  BestRecipes
//
//  Created by Pavel Kostin on 12.07.2024.
//

import UIKit


final class DetailCheckBox: UIView {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blackCheck")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        addSubviews(image)
        
    }
    
}
