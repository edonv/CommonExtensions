//
//  Publisher+flatMapZip.swift
//  
//
//  Created by Edon Valdman on 8/17/22.
//

import Foundation
import Combine

// MARK: - Flat Map Zip

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Publisher {
    /// Combines elements from another publisher, created by transforming elements of the upstream publisher,
    /// and deliver pairs of elements as tuples.
    /// - Parameters:
    ///   - maxPublishers: Specifies the maximum number of concurrent publisher subscriptions, or unlimited
    ///   if unspecified.
    ///   - transform: A closure that takes elements of the upstream publisher as a parameter and returns a
    ///   transformed publisher.
    /// - Returns: A publisher that publishes zipped elements from the upstream publisher with elements of the
    /// transformed publisher.
    public func flatMapZip<P>(maxPublishers: Subscribers.Demand = .unlimited, _ transform: @escaping (Self.Output) throws -> P) -> AnyPublisher<(Self.Output, P.Output), Self.Failure> where P: Publisher, Self.Failure == P.Failure {
        self
            .tryFlatMap(maxPublishers: maxPublishers) { result in
                return Publishers.Zip(Just(result)
                                        .setFailureType(to: Self.Failure.self)
                                        .eraseToAnyPublisher(),
                                      try transform(result))
            }.eraseToAnyPublisher()
    }
    
    /// Combines elements from another publisher, created by transforming elements of the upstream publisher,
    /// and deliver pairs of elements as tuples.
    /// - Parameters:
    ///   - maxPublishers: Specifies the maximum number of concurrent publisher subscriptions, or unlimited
    ///   if unspecified.
    ///   - keyPath: The key path of a property on `Output`.
    ///   - transform: A closure that takes a property of elements of the upstream publisher as a parameter and
    ///   returns a transformed publisher.
    /// - Returns: A publisher that publishes zipped elements from the upstream publisher with elements of the
    /// transformed publisher.
    public func flatMapZip<T, P>(maxPublishers: Subscribers.Demand = .unlimited, _ keyPath: KeyPath<Self.Output, T>, _ transform: @escaping (T) throws -> P) -> AnyPublisher<(Self.Output, P.Output), Self.Failure> where P: Publisher, Self.Failure == P.Failure {
        self
            .tryFlatMap(maxPublishers: maxPublishers) { result in
                return Publishers.Zip(Just(result)
                                        .setFailureType(to: Self.Failure.self)
                                        .eraseToAnyPublisher(),
                                      try transform(result[keyPath: keyPath]))
            }.eraseToAnyPublisher()
    }
}
