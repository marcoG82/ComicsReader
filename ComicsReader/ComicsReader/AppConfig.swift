//
//  AppConfig.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation
import ShortcutFoundation
import ComicReaderNetwork

struct AppConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(NetworkLayer.self) {
            NetworkLayer()
        }
    }
}
