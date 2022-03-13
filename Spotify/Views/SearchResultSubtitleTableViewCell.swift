//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Вардан Мукучян on 20.10.2021.
//

import UIKit
import SDWebImage


class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let icomImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(icomImageView)
        contentView.addSubview(subtitleLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height-10
        icomImageView.frame = CGRect(x: 10,
                                     y: 5,
                                     width: imageSize,
                                     height: imageSize)
        let labelSize = contentView.height/2
        label.frame = CGRect(x: icomImageView.right+10,
                             y: 0,
                             width: contentView.width - icomImageView.right-15,
                             height: labelSize)
        subtitleLabel.frame = CGRect(x: icomImageView.right+10,
                                     y: label.bottom,
                                     width: contentView.width - icomImageView.right-15,
                                     height: labelSize)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        icomImageView.image = nil
        subtitleLabel.text = nil
    }
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        icomImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
}
