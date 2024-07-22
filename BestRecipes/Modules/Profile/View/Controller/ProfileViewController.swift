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
        
        configureUI()
        setupDelegates()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        loadProfileAvatar()
    }
}

// MARK: - Set Delegates
private extension ProfileViewController {
    func setupDelegates() {
        profileView.delegate = self
        profileView.setCollectionViewDelegate(self, dataSource: self)
    }
}

// MARK: - CollectionView Data Source
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

// MARK: - CollectionView Delegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select #\(indexPath.row)")
    }
}

// MARK: - CollectionView FlowLayout Delegate
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    /// collection item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: collectionViewWidth * 0.58)
    }
}

// MARK: - ProfileView Delegate
extension ProfileViewController: ProfileViewProtocol {
    func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func loadProfileAvatar() {
        let imageData = presenter.loadImage(imageUrl: K.profileAvatarName)
        profileView.updateProfileAvatar(imageData)
    }
}

// MARK: - ImagePicker Controller Delegate
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileView.profileImageView.image = selectedImage
            
            if let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
                presenter.saveImage(K.profileAvatarName, imageData: imageData)
            }
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
