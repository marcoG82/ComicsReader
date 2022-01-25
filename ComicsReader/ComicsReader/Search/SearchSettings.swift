//
//  SearchSettings.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import Foundation
import Combine

final class SearchSettings: ObservableObject {
    init() { }
    
    @Published var issueNumber: Int = 0
    @Published var searchText = String()
}
