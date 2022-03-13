//
//  LibralyToggleVIew.swift
//  Spotify
//
//  Created by Вардан Мукучян on 29.10.2021.
//

import UIKit

protocol LibralyToggleViewDelelgate: AnyObject {
    func libralyViewControllerDidTapPlaylist(_ toggleView: LibralyToggleView)
    func libralyViewControllerDidTapAlbum(_ toggleView: LibralyToggleView)
}

class LibralyToggleView: UIView {
    
    enum State {
        case playlist
        case album
            }
    var state: State = .playlist
    
    weak var delegate: LibralyToggleViewDelelgate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylistButton), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbumButton), for: .touchUpInside)
    }
    
    @objc func didTapPlaylistButton() {
        state = .playlist
        delegate?.libralyViewControllerDidTapPlaylist(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
    
    @objc func didTapAlbumButton() {
        state = .album
        delegate?.libralyViewControllerDidTapAlbum(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(to state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
