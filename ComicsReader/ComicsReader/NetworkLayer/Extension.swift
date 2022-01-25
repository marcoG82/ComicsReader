//
//  Extension.swift
//  ComicsReader
//
//  Created by Marco Giustozzi on 2022-01-25.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
