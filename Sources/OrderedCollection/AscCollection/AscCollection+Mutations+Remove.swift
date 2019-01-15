//
//  AscCollection+Mutations+Remove.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection where Buffer == [Element] {
    public
    mutating func remove(at index: Int) -> Element {
        return buffer.remove(at: index)
    }

    /// Removes and returns the last element of the collection.
    ///
    /// The collection must not be empty.
    ///
    /// Calling this method may invalidate all saved indices of this
    /// collection. Do not rely on a previously stored index value after
    /// altering a collection with any operation that can change its length.
    ///
    /// - Returns: The last element of the collection.
    ///
    /// - Complexity: O(1)
    public
    mutating func removeLast() -> Element {
        return buffer.removeLast()
    }

    /// Removes all elements from the array.
    ///
    /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
    ///   the array after removing its elements. The default value is
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    public
    mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        buffer.removeAll(keepingCapacity: keepCapacity)
    }
}
