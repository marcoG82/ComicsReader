//
//  ComicsReaderApp.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-20.
//

import SwiftUI
import Combine

@main
struct ComicsReaderApp: App {
    
    let viewModel = MainViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: viewModel)
                .onAppear {
                    viewModel.fetchStories()
                }
        }
    }
}
