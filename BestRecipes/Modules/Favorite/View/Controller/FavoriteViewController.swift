//
//  FavoriteViewController.swift
//  BestRecipes
//
//  Created by realeti on 04.07.2024.
//

import UIKit
import SwiftUI

protocol FavoriteViewProtocol: AnyObject {
    
}

final class FavoriteViewController: UIViewController, FavoriteViewProtocol {
    
    var presenter: FavoritePresenterProtocol!
    
    private let tableView = FavoriteTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        self.navigationItem.title = "Saved recipes"
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.loadRecipes()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension FavoriteViewController: UITableViewDelegate , UITableViewDataSource {
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index\(indexPath)at row\(indexPath.row) ")
        tableView.deselectRow(at: indexPath, animated: false)
    }
    //MARK: - DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "BRTrendingTableViewCell", for: indexPath) as? FavoriteTableViewCell else {
            print("debag1")
            return UITableViewCell()
        }
        let selectedrecipe = presenter.recipes[indexPath.row]
        cell.delegate = self
        
        cell.configureCell(
            rating: selectedrecipe.rating,
            imageUrl: selectedrecipe.imageURL ?? "",
            title: selectedrecipe.title ?? "",
            author: selectedrecipe.author ?? "",
            index: indexPath
        )
        
        print(cell)
        return cell
    }

    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Расширение для превью Превью

extension UINavigationController {
    
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        func makeUIViewController (context: Context) -> some UIViewController {
            viewController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}

//MARK: - Превью

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        UINavigationController (rootViewController: FavoriteViewController()).showPreview()
        
    }
}
