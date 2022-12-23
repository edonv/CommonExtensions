//
//  Array+sortByKeyPath.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation

// MARK: - Array Sorting by KeyPath

extension Array {
    /// <#Description#>
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - areInIncreasingOrder: <#areInIncreasingOrder description#>
    /// - Throws: <#description#>
    /// - Returns: <#description#>
    public func sorted<T>(by keyPath: KeyPath<Element, T>,
                          _ areInIncreasingOrder: (T, T) throws -> Bool) rethrows -> Self {
        return try self.sorted(by: { try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - areInIncreasingOrder: <#areInIncreasingOrder description#>
    /// - Throws: <#description#>
    public mutating func sort<T>(by keyPath: KeyPath<Element, T>,
                                 _ areInIncreasingOrder: (T, T) throws -> Bool) rethrows {
        try self.sort(by: { try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) })
    }
}
