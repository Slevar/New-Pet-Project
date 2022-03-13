//
//  NewReleasesResponce.swift
//  Spotify
//
//  Created by Вардан Мукучян on 05.10.2021.
//

import Foundation

struct NewRealeasesResponce: Codable {
    let albums: AlbumsResponce
}

struct AlbumsResponce: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}


//keyNotFound(CodingKeys(stringValue: "artist", intValue: nil), Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "albums", intValue: nil), CodingKeys(stringValue: "items", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0)], debugDescription: "No value associated with key CodingKeys(stringValue: \"artist\", intValue: nil) (\"artist\").", underlyingError: nil))
