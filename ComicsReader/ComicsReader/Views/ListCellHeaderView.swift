//
//  ListCellHeaderView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

struct ListCellHeaderView: View {
    let comic: IdentifiableComic
    
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
