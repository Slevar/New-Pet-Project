//
//  UserProfile.swift
//  Spotify
//
//  Created by Вардан Мукучян on 14.03.2021.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String?
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable]
    let id: String
    let product: String
    let images: [APIImage]
}


