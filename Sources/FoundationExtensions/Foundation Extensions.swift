//
//  Foundation Extensions.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation

// MARK: - Array Sorting by KeyPath

extension Array {
    func sorted<T>(by keyPath: KeyPath<Element, T>,
                   _ areInIncreasingOrder: (T, T) throws -> Bool) rethrows -> Self {
        return try self.sorted(by: { try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
}
