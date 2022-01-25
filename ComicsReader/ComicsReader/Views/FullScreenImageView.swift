//
//  FullScreenImageView.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-24.
//

import SwiftUI

///We reuse the same view for showing both the fetched comics and the stored comic images in fullScreen
struct FullScreenImageView: View {
    let imageUrl: String?
    let comicImage: UIImage?
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            if let url = imageUrl {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .renderingMode(.original)
                } placeholder: {
                    ProgressView()
                }
            } else if let image = comicImage {
                Image(uiImage: image)
            }
        }
    }
}
