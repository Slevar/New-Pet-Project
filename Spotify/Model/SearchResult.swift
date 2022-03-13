//
//  SearchResult.swift
//  Spotify
//
//  Created by Вардан Мукучян on 19.10.2021.
//

import Foundation

enum SearchResult {
    case album(model: Album)
    case artist(model: Artist)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
