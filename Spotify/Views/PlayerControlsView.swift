//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Вардан Мукучян on 21.10.2021.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsVew: PlayerControlsView)
    func playerControlsViewDidTapNextButton(_ playerControlsVew: PlayerControlsView)
    func playerControlsViewDidTapBackwordButton(_ playerControlsVew: PlayerControlsView)
    func playerControlsView(_ playerControlsVew: PlayerControlsView, didSlideSlider value: Float)
}
struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}
final class PlayerControlsView: UIView {

     private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 1
        name.text = "Drake"
        name.font = .systemFont(ofSize: 22, weight: .semibold)
        return name
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.numberOfLines = 1
        subtitle.text = "Album of the year"
        subtitle.font = .systemFont(ofSize: 18, weight: .regular)
        subtitle.textColor = .secondaryLabel
        return subtitle
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        addSubview(subtitleLabel)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        clipsToBounds = true
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
    }
    
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    @objc func didTapBackButton() {
        delegate?.playerControlsViewDidTapBackwordButton(self)
    }
    @objc func didTapNextButton() {
        delegate?.playerControlsViewDidTapNextButton(self)
    }
    @objc func didTapPlayPauseButton() {
        self.isPlaying = !self.isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
        
        //Update icon
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 10, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 0, y: subtitleLabel.bottom+20, width: width-20, height: 44)

        let buttonSize: CGFloat = 60
        
        playPauseButton.frame = CGRect(x: (width-buttonSize)/2, y: volumeSlider.bottom+30, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left-80-buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        nextButton.frame = CGRect(x: playPauseButton.right + 80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    }
    
    func configure(with model: PlayerControlsViewViewModel) {
        nameLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}
