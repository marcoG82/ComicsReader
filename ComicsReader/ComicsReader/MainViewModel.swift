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
    @Published var filterString = String()
    @Published var filterIssue = 0
    @Published var error: NetworkLayer.Error?
    @Published private var allComics = [IdentifiableComic]() {
        didSet {
            print(allComics.count)
        }
    }
    private var subriscrions = Set<AnyCancellable>()
    
    var comics: [IdentifiableComic] {
        guard filterString != "" || filterIssue != 0 else {
            return self.allComics
        }
        var filteredComics = [IdentifiableComic]()
        if filterString != "" {
            filteredComics = allComics.filter {
                $0.title.contains(filterString) || $0.alt.contains(filterString) || $0.title.contains(filterString)
            }
        } else {
            filteredComics = allComics.filter { $0.num == filterIssue }
        }
        return filteredComics
    }
    
    func fetchComics() {
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
                    if comic.num == 2571 {
                        self.allComics.insert(IdentifiableComic(comic), at: 0)
                    } else {
                        self.allComics.append(IdentifiableComic(comic))
                    }
                }
                self.error = nil
            })
            .store(in: &subriscrions)
    }
}
