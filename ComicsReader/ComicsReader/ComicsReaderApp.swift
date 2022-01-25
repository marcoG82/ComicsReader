//
//  ComicsReaderApp.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-20.
//

import SwiftUI
import Combine
import ShortcutFoundation

@main
struct ComicsReaderApp: App {
    let viewModel = MainViewModel()
    let searchSettings = SearchSettings()
    let context = Context(AppConfig())
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        searchSettings.$issueNumber
            .assign(to: \.filterIssue, on: viewModel)
            .store(in: &subscriptions)
        
        searchSettings.$searchText
            .assign(to: \.filterString, on: viewModel)
            .store(in: &subscriptions)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: viewModel)
                .environmentObject(searchSettings)
                .onAppear {
                    viewModel.fetchComics()
                }
        }
    }
}
