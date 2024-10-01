//
//  Publisher+asVoid.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import Combine

// MARK: - As Void

@available(macOS 10.15, iOS 13, *)
extension Publisher {
    /// Erases the value of the upstream publisher, carrying only the completion state downstream.
    public func asVoid() -> AnyPublisher<Void, Failure> {
        return self
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
