//
//  NetworkError.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation

extension NetworkLayer {
    /// API Errors.
    enum Error: LocalizedError, Identifiable {
        var id: String { localizedDescription }
        
        case addressUnreachable(URL)
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid response from server."
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            }
        }
    }
}
