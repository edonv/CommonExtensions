//
//  SwiftUI Extensions.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation
import SwiftUI

// MARK: - Optional Binding Operator

extension Binding {
    static func ?? (lhs: Binding<Optional<Value>>, rhs: Value) -> Binding<Value> {
        Binding(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
}
