//
//  MainViewModel.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private let api = NetworkLayer()
    
    @Published private var allComics = [IdentifiableComic]() {
        didSet {
            print(allComics.count)
        }
    }
    private var subriscrions = Set<AnyCancellable>()
    
    var comics: [IdentifiableComic] {
        return allComics
    }
    
    @Published var error: NetworkLayer.Error? = nil
    
    func fetchStories() {
        api
            .comics()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("MyError: ", error.localizedDescription)
                    self.error = error
                }
            }, receiveValue: { comics in
                for comic in comics {
                    self.allComics.append(IdentifiableComic(comic))
                }
                self.error = nil
            })
            .store(in: &subriscrions)
    }
}
