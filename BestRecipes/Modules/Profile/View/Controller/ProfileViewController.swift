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
        profileView.delegate = self
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }
    
    // MARK: - Set Delegates
    private func setupDelegates() {
        profileView.setCollectionViewDelegate(self, dataSource: self)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.myRecipesCell, for: indexPath) as? MyRecipesCollectionCell else {
            return UICollectionViewCell()
        }
        
        let cellConfig = MyRecipeCellConfiguration(
            rating: 5.0,
            title: "Title",
            ingredientsCount: 0,
            recipeMinutes: 0,
            indexPath: indexPath
        )
        cell.configure(with: cellConfig)
        cell.updateRecipeImage(with: Data())
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select #\(indexPath.row)")
    }
}

// MARK: - CollectionView FlowLayout Delegate methods
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    /// collection item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: collectionViewWidth * 0.58)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileView.profileImageView.image = selectedImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
