//
//  ListCellButtonView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

struct ListCellButtonView: View {
    let comic: IdentifiableComic
    let model: MainViewModel
    @EnvironmentObject var comicsStore: ComicsStore
    
    var body: some View {
        HStack {
            Spacer()
            CTAButton(title: "Save to Favorites") {
                comicsStore.addFavoriteComic(comic: comic)
            }
            .disabled(!comicsStore.shouldFavorite(comic))
        }
    }
}
