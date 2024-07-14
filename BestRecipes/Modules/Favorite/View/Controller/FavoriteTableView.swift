//
//  FavoriteTableView.swift
//  BestRecipes
//
//  Created by Руслан Алламбергенов on 07.07.2024.
//

import UIKit

final class FavoriteTableView: UITableView {
    
    //MARK: - Properties
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        self.separatorStyle = .none
        configure()
        
        
        register(FavoriteTableViewCell.self, forCellReuseIdentifier: "BRTrendingTableViewCell")
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





//MARK: - Internal Methods

private extension FavoriteTableView {
    
    //MARK: - Setup UI
    
    func configure() {
        backgroundColor = .none
        bounces = false
        showsVerticalScrollIndicator = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
}
