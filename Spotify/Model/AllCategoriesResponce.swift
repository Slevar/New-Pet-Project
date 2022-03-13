//
//  APICategoriesResponce.swift
//  Spotify
//
//  Created by Вардан Мукучян on 18.10.2021.
//

import Foundation

struct AllCategoriesResponce: Codable {
    let categories: Categories
}
struct Categories: Codable {
    let items: [Category]
}
struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
