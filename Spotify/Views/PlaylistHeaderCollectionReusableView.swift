//
//  PalylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Вардан Мукучян on 10.10.2021.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func plalylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

 class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 22, weight: .semibold)
        return name
    }()
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.textColor = .secondaryLabel
        description.font = .systemFont(ofSize: 20, weight: .regular)
        description.numberOfLines = 0
        return description
    }()
    private let ownerLabel: UILabel = {
        let owner = UILabel()
        owner.font = .systemFont(ofSize: 20, weight: .regular)
        return owner
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButtom: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 30,
                                weight: .regular))
        button.setImage(image, for: .normal)
        // Круг
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButtom)
        playAllButtom.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    @objc private func didTapPlayAll() {
        delegate?.plalylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height/2.2
        imageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width-20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width-20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: ownerLabel.bottom, width: width-20, height: 44)
        playAllButtom.frame = CGRect(x: width-80, y: descriptionLabel.bottom-5, width: 60, height: 60)

    }
    
    func configure(with viewModel: PlalylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.ownerName
        imageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
        
    }
    
}


