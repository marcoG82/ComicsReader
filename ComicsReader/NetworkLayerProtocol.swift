//
//  NetworkLayerProtocol.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation
import Combine

protocol NetworkLayerProtocol {
    func comics() -> AnyPublisher<[Comic], Error>
}
