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
    @StateObject private var comicsStore: ComicsStore
    @State private var showAlert = false
//    let context = Context(AppDependencies.configs as! Config)
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        let comicsStore: ComicsStore
        do {
            comicsStore = try ComicsStore(withChecking: true)
        } catch {
            showAlert = true
            print("Couldn't load favorite comics")
            comicsStore = ComicsStore()
        }
        _comicsStore = StateObject(wrappedValue: comicsStore)
        
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
                .environmentObject(comicsStore)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Favorites"),
                          message: Text(
                          """
                            Unfortunately we can’t load your Favorite Comics.
                            Email support:
                            support@jdoe.com
                          """))
                }
                .onAppear {
                    viewModel.fetchComics()
                }
        }
    }
}
