//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Вардан Мукучян on 07.10.2021.
//

import UIKit
import SDWebImage

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"

        
    private let albumCoverImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        //label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        //label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Image
        albumCoverImageView.frame = CGRect(x: 5,
                                              y: 2,
                                              width: contentView.height-4,
                                              height: contentView.height-4)
        // Labels
        trackNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                         y: 0,
                                         width: contentView.width-albumCoverImageView.right-5,
                                         height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                        y: contentView.height/2,
                                        width: contentView.width-albumCoverImageView.right-5,
                                        height: contentView.height/2)
       
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    }
