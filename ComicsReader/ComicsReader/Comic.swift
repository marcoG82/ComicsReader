//
//  Comic.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-23.
//

import Foundation
import UIKit

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
