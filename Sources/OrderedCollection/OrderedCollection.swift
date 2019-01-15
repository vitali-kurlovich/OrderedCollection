//
//  OrderedCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/8/19.
//

import Foundation

public
enum OrderedCollectionError: Error {
    case IncorrectOrderError
    case IncorrectValueError
}

public
protocol OrderedCollection: BinarySearch {
    var isAscending: Bool { get }
}

public
extension OrderedCollection {
    func range(equal: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(equal: equal, range: range, reverse: !isAscending)
    }

    func range(less: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(less: less, range: range, reverse: !isAscending)
    }

    func range(greater: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(greater: greater, range: range, reverse: !isAscending)
    }
}

public
extension OrderedCollection {
    /// Returns a Boolean value indicating whether the collection contains the
    /// given element.
    ///
    /// - Parameter element: The element to find in the collection.
    /// - Parameter range: The range to find the element in the collection.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(ln(*n*)), where *n* is the length of the collection.

    func contains(_ element: Self.Element, range: Self.Indices? = nil) -> Bool {
//        if isAscending {
//            let range = range != nil ? range! : indices
//            return binarySearchOneAsc(equal: element, leftIndex: range.first! , rightIndex: range.last!) != nil
//        }

        return binarySearch(equal: element, range: range, reverse: !isAscending) != nil
    }

    func contains(less: Self.Element, range: Self.Indices? = nil) -> Bool {
        guard count > 0 else { return false }
        return binarySearch(less: less, range: range, reverse: !isAscending) != nil
    }

    func contains(greater: Self.Element, range: Self.Indices? = nil) -> Bool {
        guard count > 0 else { return false }

        return binarySearch(greater: greater, range: range, reverse: !isAscending) != nil
    }
}

public
extension OrderedCollection {
    /// Returns the minimum element in the collection.
    ///
    /// - Returns: The collection's minimum element. If the collection has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*1*)

    func min() -> Self.Element? {
        guard count > 0 else { return nil }
        if isAscending {
            return first
        }
        return last
    }

    /// Returns the maximum element in the collection.
    ///
    /// - Returns: The collection's minimum element. If the collection has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*1*)
    func max() -> Self.Element? {
        guard count > 0 else { return nil }
        if isAscending {
            return last
        }
        return first
    }

    func minmax() -> (min: Self.Element, max: Self.Element)? {
        guard let min = min(), let max = max() else {
            return nil
        }
        return (min: min, max: max)
    }
}
