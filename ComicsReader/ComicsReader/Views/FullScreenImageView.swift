//
//  FullScreenImageView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageUrl: String
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .renderingMode(.original)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
