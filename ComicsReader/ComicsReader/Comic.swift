//
//  Comic.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation

struct Comic: Codable {
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
    
    init(_ comic: Comic) {
        self.month = comic.month
        self.num = comic.num
        self.link = comic.link
        self.year = comic.year
        self.news = comic.news
        self.safe_title = comic.safe_title
        self.transcript = comic.transcript
        self.alt = comic.alt
        self.img = comic.img
        self.title = comic.title
        self.day = comic.day
    }
}

extension Comic: Comparable {
    static func < (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.num > rhs.num
    }
}

extension Comic: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(title)\nby \(num)\n\(img)\n-----"
    }
}
