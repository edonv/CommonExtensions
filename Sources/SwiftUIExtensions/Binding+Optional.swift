//
//  Binding+Optional.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import SwiftUI

// MARK: - Optional Binding Operator

@available(iOS 13, macOS 10.15, macCatalyst 13, tvOS 13, watchOS 6, *)
extension Binding {
    /// Optional operator for `Binding` types.
    /// - Parameters:
    ///   - lhs: The `Binding` value to unwrap when `nil`.
    ///   - rhs: The `Value` to return when `lhs` is `nil`.
    /// - Returns: Returns `lhs` if it's not `nil`. Otherwise, `rhs`.
    public static func ?? (lhs: Binding<Optional<Value>>, rhs: Value) -> Binding<Value> {
        Binding(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
}
