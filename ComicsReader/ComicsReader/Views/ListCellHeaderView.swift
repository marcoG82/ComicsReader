//
//  ListCellHeaderView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI
import ComicReaderNetwork

struct ListCellHeaderView: View {
    let comic: Comic
    
    var body: some View {
        HStack {
            Text("#" + "\(comic.num)" + " " + comic.title)
                .font(.headline)
                .bold()
            Spacer()
            DateBadge(comic: comic)
        }
    }
}
