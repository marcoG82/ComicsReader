//
//  IdentifiableComic.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation

/// This struct is basically the same as 'Comic' in the NetworkLayer but we need to convert
///                          Comic -> IdentifiableComic
///in order to present the elements in a SwiftUI list or form that, in fact, accept only elements that conform to Identifiable protocol
struct IdentifiableComic: Identifiable {
    let id = UUID()
    let month: String
    let num: Int
    let link: String
    let year: String
    let news: String
    let safe_title: String
    let transcript: String
    let alt: String
    let img: String
    let title: String
    let day: String
}
