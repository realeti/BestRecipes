//
//  DetailTableView.swift
//  tests
//
//  Created by Pavel Kostin on 01.07.2024.
//

import UIKit

final class DetailTableView: UITableView {
    
    weak var tableViewData: DetailTableViewData?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super .init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    private func configure() {
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        register(DetailViewCell.self, forCellReuseIdentifier: DetailViewCell.identifier)
        register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
        separatorStyle = .none
        allowsSelection = false
        isScrollEnabled = false
        
        estimatedRowHeight = 94
        rowHeight = UITableView.automaticDimension
    }
}

    extension DetailTableView {
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 53))
            headerView.backgroundColor = .white
            
            let leftLabel = UILabel()
            leftLabel.text = "Ingredients"
            leftLabel.font = Font.getFont(.poppinsBold, size: 20)
            headerView.addSubview(leftLabel)
            
            let rightLabel = UILabel()
            rightLabel.text = "\(tableViewData?.numberOfIngredients() ?? 0) items"
            rightLabel.font = Font.getFont(.poppinsRegular, size: 14)
            rightLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            rightLabel.textAlignment = .right
            headerView.addSubview(rightLabel)
            
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leftLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
                leftLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                
                rightLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                rightLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        }
        
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            53
        }
    }


extension DetailTableView: UITableViewDelegate {}

extension DetailTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData?.numberOfIngredients() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: DetailViewCell.identifier,
            for: indexPath
        )
                as? DetailViewCell
        else {
            return self.dequeueReusableCell(
                withIdentifier: "identifier",
                for: indexPath
            )
        }
        
        if let ingredient = tableViewData?.ingredient(at: indexPath.row) {
            cell.configure(with: ingredient)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        89
    }
}

