//
//  Future+initWithValue.swift
//  
//
//  Created by Edon Valdman on 12/22/22.
//

import Foundation
import Combine

// MARK: - Convenience Future Init

@available(OSX 10.15, iOS 13, *)
extension Future {
    /// Initializes a new `Future` that immediately completes with the provided `value`.
    /// - Parameter value: An `Output` that the new `Future` should complete with.
    public convenience init(withValue value: Output) {
        self.init { promise in
            promise(.success(value))
        }
    }
}
