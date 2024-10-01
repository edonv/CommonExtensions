//
//  Publisher+weakAssign.swift
//  
//  https://www.swiftbysundell.com/articles/combine-self-cancellable-memory-management/
//  Created by John Sundell on 2/5/21.
//

import Combine

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Publisher where Failure == Never {
    public func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
