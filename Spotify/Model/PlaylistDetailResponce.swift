//
//  PlaylistDetailResponce.swift
//  Spotify
//
//  Created by Вардан Мукучян on 09.10.2021.
//

import Foundation

struct PlaylistDetailResponce: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponce
}

struct PlaylistTracksResponce: Codable {
    let items: [Playlistitem]
}

struct Playlistitem: Codable {
    let track: AudioTrack
}
