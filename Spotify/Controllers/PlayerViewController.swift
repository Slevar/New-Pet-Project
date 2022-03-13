//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Вардан Мукучян on 14.03.2021.
//

import UIKit
import SDWebImage

// 1. Создаём протокол делегирования
protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackword()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSourse?
    // 2. Создаём переменную, которая будет хранить того то, кто поддерживает протокол(имеет функции) укажем себя и распишем функционал / реализуем методы протокола
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBurButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(x: 10,
                                    y: imageView.bottom+10,
                                    width: view.width-20,
                                    height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
        
    }
    
    private func configureBurButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapAction() {
        //dismiss(animated: true, completion: nil)
    }
    
    func refreshUI() {
        configure()
        
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsView(_ playerControlsVew: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsVew: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapNextButton(_ playerControlsVew: PlayerControlsView) {
        delegate?.didTapForward()

    }
    
    func playerControlsViewDidTapBackwordButton(_ playerControlsVew: PlayerControlsView) {
        delegate?.didTapBackword()
    }
}
