//
//  ProfileViewController.swift
//  BestRecipes
//
//  Created by realeti on 04.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: ProfilePresenterProtocol!
    
    // MARK: - Private Properties
    private var profileView: ProfileView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        profileView = ProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
}
