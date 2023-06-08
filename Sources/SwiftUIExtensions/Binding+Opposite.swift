//
//  Binding+Opposite.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import SwiftUI

// MARK: - Opposite Binding Prefix and Property

@available(iOS 13, macOS 10.15, macCatalyst 13, tvOS 13, watchOS 6, *)
public prefix func !(value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool> {
        !value.wrappedValue
    } set: {
        value.wrappedValue = !$0
    }
}

@available(iOS 13, macOS 10.15, macCatalyst 13, tvOS 13, watchOS 6, *)
extension Binding where Value == Bool {
    /// Opposite property for `Binding<Bool>`.
    public var opposite: Binding<Value> {
        Binding<Value> {
            !self.wrappedValue
        } set: {
            self.wrappedValue = !$0
        }
    }
}
