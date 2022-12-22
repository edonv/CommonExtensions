//
//  Publisher+TryFlatMap.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import Combine

// MARK: - Try Flat Map

@available(OSX 10.15, iOS 13, *)
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
    ) -> Publishers.FlatMap<AnyPublisher<P.Output, Self.Failure>, Self> where Self.Failure == P.Failure {
        return flatMap(maxPublishers: maxPublishers, { input -> AnyPublisher<P.Output, Self.Failure> in
            do {
                return try transform(input)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(outputType: P.Output.self, failure: error as! Failure)
                    .eraseToAnyPublisher()
            }
        })
    }
}
