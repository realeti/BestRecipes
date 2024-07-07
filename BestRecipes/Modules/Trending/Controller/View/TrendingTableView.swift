//
//  BRCollectionView.swift
//  BestRecipes
//
//  Created by Evgenii Mazrukho on 01.07.2024.
//

import UIKit

final class TrendingTableView: UITableView {
    
    //MARK: - Properties
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        configure()
        setDelegates()
        
        register(TrendingTableViewCell.self, forCellReuseIdentifier: "BRTrendingTableViewCell")
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Delegate

extension TrendingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index\(indexPath)at row\(indexPath.row) ")
        deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - DataSource

extension TrendingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: "BRTrendingTableViewCell", for: indexPath) as? TrendingTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}


//MARK: - Internal Methods

private extension TrendingTableView {
    
    //MARK: - Setup UI
    
    func configure() {
        backgroundColor = .none
        bounces = false
        showsVerticalScrollIndicator = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setDelegates() {
        delegate = self
        dataSource = self
    }
}
