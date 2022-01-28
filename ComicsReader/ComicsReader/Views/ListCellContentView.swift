//
//  ListCellContentView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI
import ComicReaderNetwork

struct ListCellContentView: View {
    let comic: Comic
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: comic.img)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: 300,
                   alignment: .center)
            .padding(8)
            Text(comic.alt)
                .font(.subheadline)
                .italic()
                .frame(maxHeight: 200)
        }
    }
}
