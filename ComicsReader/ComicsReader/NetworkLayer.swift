//
//  NetworkLayer.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import Combine
import UIKit

struct NetworkLayer {
    
    /// API Errors.
    public enum Error: LocalizedError, Identifiable {
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
    
    /// Maximum number of comics to fetch (reduce for lower API strain during development).
    var maxComics = 10
    
    /// A shared JSON decoder to use in calls.
    private let decoder = JSONDecoder()
    
    private let apiQueue = DispatchQueue(label: "NetworkLayer", qos: .default, attributes: .concurrent)
    
    func comic(num: Int) -> AnyPublisher<Comic, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.comic(num).url)
            .receive(on: apiQueue)
            .map { $0.data }
            .decode(type: Comic.self, decoder: decoder)
            .mapError { error -> Error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.comic(num).url)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func exampleComic() -> AnyPublisher<Comic, Error> {
        URLSession.shared.dataTaskPublisher(for: EndPoint.example.url)
            .receive(on: apiQueue)
            .map { $0.0 }
            .decode(type: Comic.self, decoder: decoder)
            .mapError { error -> Error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.example.url)
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func mergedComics(nums comicNums: [Int]) -> AnyPublisher<Comic, Error> {
        let comicNums = Array(comicNums.prefix(maxComics))

        precondition(!comicNums.isEmpty)

        let initialPublisher = exampleComic()

        return comicNums.reduce(initialPublisher) { (combined, num) -> AnyPublisher<Comic, Error> in
            return combined.merge(with: comic(num: num))
                .eraseToAnyPublisher()
        }
    }
    
    func comics() -> AnyPublisher<[Comic], Error> {
        let indexes = indexes()
        var array: [AnyPublisher<Comic, Error>] = []
        for num in indexes {
            array.append(comic(num: num))
        }
        return Publishers.MergeMany(array)
            .collect()
            .flatMap { _ in
                return self.mergedComics(nums: indexes)
            }
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func indexes() -> [Int] {
        let indexes: [Int] = (0..<maxComics).map { _ in .random(in: 1...2570) }
        return indexes.sorted(by: >).uniqued()
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}