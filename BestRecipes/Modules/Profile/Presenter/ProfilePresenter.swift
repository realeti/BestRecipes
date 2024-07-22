//
//  ProfilePresenter.swift
//  BestRecipes
//
//  Created by realeti on 21.07.2024.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func selectImage()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, router: RouterProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties
    let router: RouterProtocol
    weak var view: ProfileViewProtocol?
    
    // MARK: - Init
    required init(view: ProfileViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
