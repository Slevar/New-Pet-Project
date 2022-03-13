//
//  PlaybachPresenter.swift
//  Spotify
//
//  Created by Вардан Мукучян on 21.10.2021.
//
// 1.Импорт данной библиотеки для настройки проигрывания музыкальных треков и видео
import AVFoundation
import Foundation
import UIKit

protocol PlayerDataSourse: AnyObject {
    var songName: String? {get}
    var subtitle: String? {get}
    var imageURL: URL? {get}
}
final class PlaybackPresenter{
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item })
//            else {
//                return nil
//            }
            return tracks[index]
        }
        return nil
    }
    var playerVC: PlayerViewController?
    // 2. Объявляем переменную для настройки проигрывания
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback (from viewController: UIViewController, track: AudioTrack) {
        // 3. Объявляем URL который хранит в себе информацию проигрывания
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        // 4. В созданную переменную в конструктор передаём URL с данными проигрывания
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        // 5. В комплишн по завершению презентации VC добавляем воспроизводящий метод
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
            self?.playerVC = vc
        }
    }
    func startPlayback (from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "")
            else { return nil }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(vc, animated: true, completion: nil)
        self.playerVC = vc
   
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .paused {
                player.play()
            } else if player.timeControlStatus == .playing {
                player.pause()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .paused {
                player.play()
            } else if player.timeControlStatus == .playing {
                player.pause()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not Playlist or album
            player?.pause()
        }
        else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            print(index)
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackword() {
        if tracks.isEmpty {
            // Not Playlist or album
            player?.pause()
        }
        else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0
        }
    }
    
    func didSlideSlider(_ value: Float) {
        print("no")
    }

}

extension PlaybackPresenter: PlayerDataSourse {
    var songName: String? {
        currentTrack?.name
    }

    var subtitle: String? {
        currentTrack?.artists.first?.name
    }

    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}

