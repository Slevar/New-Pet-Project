//
//  SettingsModels.swift
//  Spotify
//
//  Created by Вардан Мукучян on 28.09.2021.
//

import Foundation

struct Section {
    let title: String
    let option: [Option]
}

struct Option {
    let title: String
    let handler: () -> (Void)
}
