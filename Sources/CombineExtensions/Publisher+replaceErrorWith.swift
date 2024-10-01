//
//  Publisher+replaceErrorWith.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import Combine

// MARK: - Replace Error Overloads

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Publisher where Failure: Error {
    /// Handles errors from an upstream publisher by replacing it with another publisher, but only if the
    /// provided `handler` returns `true`.
    /// - Parameters:
    ///   - output: Value to replace the error with.
    ///   - handler: A closure that accepts the upstream failure as input and returns a publisher containing
    ///   the provided value to replace the upstream publisher.
    public func replaceError(with output: Output, _ handler: @escaping (Self.Failure) -> Bool) -> Publishers.Catch<Self, AnyPublisher<Output, Failure>> {
        self.catch { error -> AnyPublisher<Output, Failure> in
            if handler(error) {
                return Just(output)
                    .setFailureType(to: Failure.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        }
    }
}

// MARK: - Replace Error

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Publisher where Failure: Error, Failure: Equatable {
    /// Handles errors from an upstream publisher by replacing it with another publisher, but only if the
    /// error matches the provided error.
    /// - Parameters:
    ///   - output: Value to replace the error with.
    ///   - error: `Error` to replace.
    public func replaceError(with output: Output, _ error: Self.Failure) -> Publishers.Catch<Self, AnyPublisher<Output, Failure>> {
        self.replaceError(with: output) { $0 == error }
    }
}
