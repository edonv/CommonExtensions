//
//  Publisher+filterByKeyPath.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import Combine

// MARK: - Filter Key Path

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Publisher {
    /// Republishes all elements whose provided property match a provided value.
    /// - Parameters:
    ///   - keyPath: `KeyPath` to a property whose value should be compared.
    ///   - aValue: Value to be compared to provided property of each incoming element.
    /// - Returns: A publisher that republishes all elements whos provided property match `aValue`.
    public func filter<T: Equatable>(by keyPath: KeyPath<Output, T>, equals aValue: T) -> Publishers.Filter<Self> {
        self.filter { $0[keyPath: keyPath] == aValue }
    }
}
