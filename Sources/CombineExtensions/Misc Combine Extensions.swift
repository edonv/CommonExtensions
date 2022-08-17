//
//  Misc Combine Extensions.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation
import Combine

// MARK: - Convenience Future Init

@available(OSX 10.15, *)
extension Future {
    /// Initializes a new `Future` that immediately completes with the provided `value`.
    /// - Parameter value: An `Output` that the new `Future` should complete with.
    public convenience init(withValue value: Output) {
        self.init { promise in
            promise(.success(value))
        }
    }
}

// MARK: - Try Flat Map

@available(OSX 10.15, *)
extension Publisher {
    /// A `Publishers.FlatMap` that can throw.
    /// - Parameters:
    ///   - maxPublishers: Specifies the maximum number of concurrent publisher subscriptions, or
    ///   `.unlimited` if unspecified.
    ///   - transform: A closure that takes an element as a parameter and returns a publisher that
    ///   produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream publisher into a publisher
    /// of that element’s type.
    public func tryFlatMap<P: Publisher>(
        maxPublishers: Subscribers.Demand = .unlimited,
        _ transform: @escaping (Output) throws -> P
    ) -> Publishers.FlatMap<AnyPublisher<P.Output, Error>, Self> {
        return flatMap(maxPublishers: maxPublishers, { input -> AnyPublisher<P.Output, Error> in
            do {
                return try transform(input)
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            } catch {
                return Fail(outputType: P.Output.self, failure: error)
                    .eraseToAnyPublisher()
            }
        })
    }
}

// MARK: - As Void

@available(OSX 10.15, *)
extension Publisher {
    /// Erases the value of the upstream publisher, carrying only the completion state downstream.
    public func asVoid() -> AnyPublisher<Void, Failure> {
        return self
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}

// MARK: - Replace Error Overloads

@available(OSX 10.15, *)
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

@available(OSX 10.15, *)
extension Publisher where Failure: Error, Failure: Equatable {
    /// Handles errors from an upstream publisher by replacing it with another publisher, but only if the
    /// error matches the provided error.
    /// - Parameters:
    ///   - error: `Error` to replace.
    ///   - output: Value to replace the error with.
    public func replaceError(_ error: Self.Failure, with output: Output) -> Publishers.Catch<Self, AnyPublisher<Output, Failure>> {
        self.replaceError(with: output) { $0 == error }
    }
}
