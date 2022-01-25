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
//    let context = Context(AppDependencies.configs as! Config)
    let viewModel = MainViewModel()
    let searchSettings = SearchSettings()
    @StateObject private var comicsStore: ComicsStore
    @State private var showAlert = false
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        ///we want to initialize the ComicsStore immediately in order get the favorited comics on start. Declaring it as a StateObject
        ///and assigning as an EnvironmentObject in the ContentView will do the trick
        let comicsStore: ComicsStore
        do {
            comicsStore = try ComicsStore(withChecking: true)
        } catch {
            showAlert = true
            print("Couldn't load favorite comics")
            comicsStore = ComicsStore()
        }
        _comicsStore = StateObject(wrappedValue: comicsStore)
        
        ///we assign the two publishers issueNumber and searchText to the filter in the viewModel and later assign as an EnvironmentObject
        ///in the ContentView
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
