//
//  AppConfig.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import Combine
import ShortcutFoundation

struct AppConfig: Config {
    func configure(_ injector: Injector) {
        injector.map(NetworkLayerProtocol.self) {
            NetworkLayer()
        }
    }
}
