//
//  ProfileView.swift
//  BestRecipes
//
//  Created by realeti on 21.07.2024.
//

import UIKit

final class ProfileView: UIView {
    // MARK: - UI
    let profileImageView = UIImageView(
        image: .avatar4,
        backgroundColor: .clear,
        contentMode: .scaleAspectFill,
        cornerRadius: Metrics.profileImageSize / 2
    )
    
    private lazy var selectImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let recipesLabel = UILabel(
        text: K.myRecipes,
        color: .blackBase,
        font: .poppinsSemiBold,
        fontSize: 24
    )
    
    lazy var recipeCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(MyRecipesCollectionCell.self, forCellWithReuseIdentifier: K.myRecipesCell)
        collectionView.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: K.emptyCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Public Properties
    weak var delegate: ProfileViewProtocol?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        backgroundColor = .white
        addSubviews(profileImageView, selectImageButton, recipesLabel, recipeCollection)
    }
}

// MARK: - Public Methods
extension ProfileView {
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        recipeCollection.delegate = delegate
        recipeCollection.dataSource = dataSource
    }
    
    func updateProfileAvatar(_ imageData: Data?) {
        guard let imageData = imageData, !imageData.isEmpty else {
            profileImageView.image = .avatar2
            return
        }
        profileImageView.image = UIImage(data: imageData)
    }
}

// MARK: - Actions
private extension ProfileView {
    @objc func selectImage(_ sender: UIButton) {
        delegate?.selectImage()
    }
}

// MARK: - Setup Constraints
private extension ProfileView {
    func setupConstraints() {
        setupProfileImageConstraints()
        setupSelectImageButtonConstraints()
        setupRecipesLabelConstraints()
        setupRecipeCollectionConstraints()
    }
    
    func setupProfileImageConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 4.0),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.profileImageIndent),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.profileImageIndent).withPriority(.defaultLow),
            profileImageView.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize)
        ])
    }
    
    func setupSelectImageButtonConstraints() {
        NSLayoutConstraint.activate([
            selectImageButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            selectImageButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            selectImageButton.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            selectImageButton.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize)
        ])
    }
    
    func setupRecipesLabelConstraints() {
        NSLayoutConstraint.activate([
            recipesLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Metrics.recipesLabelTopIndent),
            recipesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.recipesLabelIndent),
            recipesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.recipesLabelIndent)
        ])
    }
    
    func setupRecipeCollectionConstraints() {
        NSLayoutConstraint.activate([
            recipeCollection.topAnchor.constraint(equalToSystemSpacingBelow: recipesLabel.bottomAnchor, multiplier: 3.0),
            recipeCollection.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2.0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: recipeCollection.trailingAnchor, multiplier: 2.0),
            recipeCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

fileprivate struct Metrics {
    static let profileImageIndent: CGFloat = 20.5
    static let profileImageSize: CGFloat = 100.0
    
    static let recipesLabelTopIndent: CGFloat = 40.0
    static let recipesLabelIndent: CGFloat = 36.0
}
