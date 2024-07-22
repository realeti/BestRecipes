//
//  ProfilePresenter.swift
//  BestRecipes
//
//  Created by realeti on 21.07.2024.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func selectImage()
    func loadProfileAvatar()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, router: RouterProtocol)
    func saveImage(_ imageName: String, imageData: Data)
    func loadImage(imageUrl: String) -> Data?
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

// MARK: - Save & Load Profile Avatar
extension ProfilePresenter {
    func saveImage(_ imageName: String, imageData: Data) {
        DataManager.shared.saveImage(imageName, imageData: imageData)
    }
    
    func loadImage(imageUrl: String) -> Data? {
        DataManager.shared.loadImage(imageUrl: imageUrl)
    }
}
