//
//  NetworkLayerConfig.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import Combine
import ShortcutFoundation
import ComicReaderNetwork

struct NetworkLayerConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(NetworkLayer.self) {
            NetworkLayer()
        }
    }
}
