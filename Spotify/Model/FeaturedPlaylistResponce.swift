//
//  FeaturedPlaylistResponce.swift
//  Spotify
//
//  Created by Вардан Мукучян on 05.10.2021.
//

import Foundation

struct FeaturedPlaylistResponce: Codable {
    let playlists: PlaylistResponce
}
struct CategoryPlaylistResponce: Codable {
    let playlists: PlaylistResponce
}

struct PlaylistResponce:Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
