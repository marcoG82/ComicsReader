//
//  FavoriteView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var comicsStore: ComicsStore
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        let filter = "Favorite Comics"
        
        List {
            Section(header: Text(filter).padding(.leading, -10)) {
                ForEach(self.comicsStore.allSavedComics) { comic in
                    NavigationLink(destination: FullScreenImageView(imageUrl: nil,
                                                                    comicImage: comicsStore.getImageFromLocal(comic))) {
                        VStack(alignment: .leading, spacing: 4) {
                            ListCellHeaderView(comic: comic)
                            ListCellContentView(comic: comic)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .listStyle(PlainListStyle())
        .buttonStyle(PlainButtonStyle())
    }
}
