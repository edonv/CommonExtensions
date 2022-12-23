//
//  Array+sortByKeyPath.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation

// MARK: - Array Sorting by KeyPath

extension Array {
    /// Sorts the array in place by the provided property of each element.
    /// - Parameters:
    ///   - keyPath: The `KeyPath` to the property of the elements to sort by.
    ///   - areInIncreasingOrder: A predicate that returns `true` if its first argument should be ordered before its second argument; otherwise, `false`. If `areInIncreasingOrder` throws an error during the sort, the elements may be in a different order, but none will be lost.
    public mutating func sort<T>(by keyPath: KeyPath<Element, T>,
                                 _ areInIncreasingOrder: (T, T) throws -> Bool) rethrows {
        try self.sort(by: { try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
    
    /// Returns the elements of the array, sorted by the provided property of each element.
    /// - Parameters:
    ///   - keyPath: The `KeyPath` to the property of the elements to sort by.
    ///   - areInIncreasingOrder: A predicate that returns `true` if its first argument should be ordered before its second argument; otherwise, `false`. If `areInIncreasingOrder` throws an error during the sort, the elements may be in a different order, but none will be lost.
    /// - Returns: A sorted array of the array's elements.
    public func sorted<T>(by keyPath: KeyPath<Element, T>,
                          _ areInIncreasingOrder: (T, T) throws -> Bool) rethrows -> Self {
        return try self.sorted(by: { try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
}
