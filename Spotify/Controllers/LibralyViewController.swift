//
//  LibralyViewController.swift
//  Spotify
//
//  Created by Вардан Мукучян on 14.03.2021.
//

import UIKit

class LibralyViewController: UIViewController {
    
    private let pLaylistVC = LibralyPlaylistViewController()
    private let albumVC = LibralyAlbumViewController()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    private let toggleView = LibralyToggleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(toggleView)
        toggleView.delegate = self
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top+55,
                                  width: view.width,
                                  height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55)
        
        toggleView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: 200,
                                  height: 55)
    }
    
    private func updateBarButtons() {
        switch toggleView.state {
        case .playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case .album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func didTapAdd() {
        pLaylistVC.showCreatePlaylistAlert()
    }
    
    private func addChildren() {
        addChild(pLaylistVC)
        scrollView.addSubview(pLaylistVC.view)
        pLaylistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        pLaylistVC.didMove(toParent: self)
                
        addChild(albumVC)
        scrollView.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumVC.didMove(toParent: self)
    }
}

extension LibralyViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100) {
            toggleView.update(to: .album)
            updateBarButtons()
        }
            else {
                toggleView.update(to: .playlist)
                updateBarButtons()

            }
    }
}

extension LibralyViewController: LibralyToggleViewDelelgate {
    func libralyViewControllerDidTapPlaylist(_ toggleView: LibralyToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()

    }
    
    func libralyViewControllerDidTapAlbum(_ toggleView: LibralyToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
    
    
}
