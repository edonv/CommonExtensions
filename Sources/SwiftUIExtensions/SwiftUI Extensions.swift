//
//  SwiftUI Extensions.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation
import SwiftUI

// MARK: - Optional Binding Operator

@available(OSX 10.15, iOS 13, *)
extension Binding {
    public static func ?? (lhs: Binding<Optional<Value>>, rhs: Value) -> Binding<Value> {
        Binding(
            get: { lhs.wrappedValue ?? rhs },
            set: { lhs.wrappedValue = $0 }
        )
    }
}

//@available(OSX 10.15, iOS 13, *)
//extension Text: ExpressibleByStringLiteral {
//    public typealias StringLiteralType = String
//    
//    public init(stringLiteral value: Self.StringLiteralType) {
//        self = Text(value)
//    }
//}
