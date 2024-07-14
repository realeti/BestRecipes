import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - UI
    
    private let backgroundImageView: UIImageView = {
        $0.image = .media
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    public lazy var favoritesButton = BRFavoritesButton()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .greyDark
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ratingStarImageView = UIImageView(
        image: .star,
        contentMode: .scaleAspectFit
    )
    
    private let ratingLabel = UILabel(
        font: .poppinsBold,
        fontSize: 14.0
    )
    
    private let titleLabel: UILabel = {
        $0.text = "How to sharwama at home"
        $0.textColor = .blackBase
        $0.font = Font.getFont(.poppinsBold, size: 16)
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let authorImageView: UIImageView = {
        $0.image = .author
        $0.layer.cornerRadius = 16
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let authorNameLabel: UILabel = {
        $0.text = "By Zeelicious foods"
        $0.textColor = .greyBase
        $0.font = Font.getFont(.poppinsRegular, size: 14)
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    weak var delegate: FavoriteViewProtocol?
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BRTrendingTableViewCell")
        
        
        configure()
        setCostraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - External Methods

extension FavoriteTableViewCell {
    func configureCell(rating: Double, imageUrl: String, title: String, author: String, index: IndexPath) {
        ratingLabel.text = String(format: "%.1f", rating)
        titleLabel.text = title
        authorNameLabel.text = author
        favoritesButton.tag = index.item
        
        DataManager.shared.getImage(imageUrl) { imageData in
            DispatchQueue.main.async {
                self.backgroundImageView.image = !imageData.isEmpty ? UIImage(data: imageData) : UIImage(named: "noimage")
            }
        }
        
        setupAuthorImage()
    }
    
    private func setupAuthorImage() {
        let images: [UIImage] = [.author, .author2]
        authorImageView.image = images.randomElement() ?? UIImage()
    }
}


//MARK: - Internal Methods

private extension FavoriteTableViewCell {
    
    //MARK: - Setup UI
    
    func configure() {
        
        contentView.addSubviews(backgroundImageView,
                    titleLabel,ratingStackView,favoritesButton,
                    authorImageView, authorNameLabel)
        
        ratingStackView.addArrangedSubviews(ratingStarImageView, ratingLabel)
        
    }
    

    
    
    func setCostraints() {
        NSLayoutConstraint.activate([
            
            
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 24),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -75),
            backgroundImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.52),
            
            ratingStackView.topAnchor.constraint(equalToSystemSpacingBelow: backgroundImageView.topAnchor, multiplier: 1.0),
            ratingStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundImageView.leadingAnchor, multiplier: 1.0),
            ratingStarImageView.heightAnchor.constraint(equalToConstant: 16.0),
            ratingStarImageView.widthAnchor.constraint(equalToConstant: 16.0),
            
            favoritesButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            favoritesButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            favoritesButton.heightAnchor.constraint(equalToConstant: 32),
            favoritesButton.widthAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            authorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: 32),
            authorImageView.widthAnchor.constraint(equalToConstant: 32),
            
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
            authorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
