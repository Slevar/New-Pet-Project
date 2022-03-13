//
//  searchResult.swift
//  Spotify
//
//  Created by Вардан Мукучян on 19.10.2021.
//

import Foundation

struct SearchResultResponce: Codable {
    let albums: SearchAlbumsResponce
    let artists: SearchArtistsResponce
    let playlists: SearchPlaylistsResponce
    let tracks: SearchTracksResponce
}
struct SearchAlbumsResponce: Codable {
    let items: [Album]
}
struct SearchArtistsResponce: Codable {
    let items: [Artist]
}
struct SearchPlaylistsResponce: Codable {
    let items: [Playlist]
}
struct SearchTracksResponce: Codable {
    let items: [AudioTrack]
}


