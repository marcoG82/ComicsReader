//
//  MainViewModel.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import Combine
import ShortcutFoundation
import ComicReaderNetwork

class MainViewModel: ObservableObject {
    @Inject var api: NetworkLayer
    @Published var filterString = String()
    @Published var filterIssue = 0
    @Published var error: Error?
    @Published private var allComics = [Comic]()
    private var subscriptions = Set<AnyCancellable>()
    
    /// leveraging the allComics array, which is a publisher, we never need to refetch comics to populate views, but we can filter through it
    /// if filters are active
    var comics: [Comic] {
        guard filterString != "" || filterIssue != 0 else {
            return self.allComics
        }
        var filteredComics = [Comic]()
        if filterString != "" {
            filteredComics = allComics.filter {
                $0.title.contains(filterString) || $0.alt.contains(filterString) || $0.title.contains(filterString)
            }
        } else {
            filteredComics = allComics.filter { $0.num == filterIssue }
        }
        return filteredComics
    }
    
    /// here we finally handle the publisher coming from the NetworkLayer
    func fetchComics() {
        api
            .getComics()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("MyError: ", error.localizedDescription)
                    self.error = error
                }
            }, receiveValue: { comics in
                self.allComics = comics
                self.error = nil
            })
            .store(in: &subscriptions)
    }
}
