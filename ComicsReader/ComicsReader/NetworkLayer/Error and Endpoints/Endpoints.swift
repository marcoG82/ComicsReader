//
//  Endpoints.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation

extension NetworkLayer {
    /// API endpoints.
    enum EndPoint {
        static let baseURL = URL(string: "https://xkcd.com/")!
        
        case example
        case comic(Int)
        
        var url: URL {
            switch self {
            case .example:
                return EndPoint.baseURL.appendingPathComponent("info.0.json")
            case .comic(let num):
                return EndPoint.baseURL.appendingPathComponent("\(num)/info.0.json")
            }
        }
    }
}
