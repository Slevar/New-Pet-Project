//
//  Artist.swift
//  Spotify
//
//  Created by Вардан Мукучян on 14.03.2021.
//

import Foundation

struct Artist: Codable {
    let external_urls: [String: String]
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    
}
