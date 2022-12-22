//
//  Text+OptionalString.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation
import SwiftUI

// MARK: - Optional String Text Init

@available(macOS 10.15, iOS 13, *)
extension Text {
    public init<S>(_ content: S?) where S : StringProtocol {
//        self.init()
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
