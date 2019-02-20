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
    @inlinable
    var isAscending: Bool { get }
}

public
extension OrderedCollection where Self.Indices == Range<Self.Index> {
    func range<R>(equal: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        return self.range(equal: equal, range: range.relative(to: self))
    }

    func range(equal: Self.Element) -> Self.Indices? {
        return range(equal: equal, range: indices)
    }

    func range<R>(less: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        return self.range(less: less, range: range.relative(to: self))
    }

    func range(less: Self.Element) -> Self.Indices? {
        return range(less: less, range: indices)
    }

    func range<R>(greater: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        return self.range(greater: greater, range: range.relative(to: self))
    }

    func range(greater: Self.Element) -> Self.Indices? {
        return range(greater: greater, range: indices)
    }
}

private
extension OrderedCollection where Self.Indices == Range<Self.Index> {
    func range(equal: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        return binarySearch(equal: equal, range: range, reverse: !isAscending)
    }

    func range(less: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        return binarySearch(less: less, range: range, reverse: !isAscending)
    }

    func range(greater: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        return binarySearch(greater: greater, range: range, reverse: !isAscending)
    }
}

public
extension OrderedCollection where Self.Indices == Range<Self.Index> {
    /// Returns a Boolean value indicating whether the collection contains the
    /// given element.
    ///
    /// - Parameter element: The element to find in the collection.
    /// - Parameter range: The range to find the element in the collection.
    /// - Returns: `true` if the element was found in the sequence; otherwise,
    ///   `false`.
    ///
    /// - Complexity: O(ln(*n*)), where *n* is the length of the collection.

    func contains<R>(_ element: Self.Element, in range: R) -> Bool where R: RangeExpression, Index == R.Bound {
        return binarySearchContain(element, range: range.relative(to: self), reverse: !isAscending)
    }

    func contains(_ element: Self.Element) -> Bool {
        return binarySearch(equal: element, reverse: !isAscending) != nil
    }

    func contains<R>(less: Self.Element, in range: R) -> Bool where R: RangeExpression, Index == R.Bound {
        return binarySearch(less: less, range: range.relative(to: self), reverse: !isAscending) != nil
    }

    func contains(less: Self.Element) -> Bool {
        return binarySearch(less: less, reverse: !isAscending) != nil
    }

    func contains<R>(greater: Self.Element, in range: R) -> Bool where R: RangeExpression, Index == R.Bound {
        return binarySearch(greater: greater, range: range.relative(to: self), reverse: !isAscending) != nil
    }

    func contains(greater: Self.Element) -> Bool {
        return binarySearch(greater: greater, reverse: !isAscending) != nil
    }
}

public
extension OrderedCollection {
    /// Returns the first index where the specified value appears in the
    /// collection.
    ///
    /// - Parameter element: An element to search for in the collection.
    /// - Returns: The first index where `element` is found. If `element` is not
    ///   found in the collection, returns `nil`.
    ///
    /// - Complexity: O(*ln(n)*), where *n* is the length of the collection.
    func firstIndex(of element: Element) -> Self.Index? {
        let range = binarySearch(equal: element, reverse: !isAscending)
        return range?.first
    }

    /// Returns the last index where the specified value appears in the
    /// collection.
    ///
    /// - Parameter element: An element to search for in the collection.
    /// - Returns: The last index where `element` is found. If `element` is not
    ///   found in the collection, this method returns `nil`.
    ///
    /// - Complexity: O(*ln(n)*), where *n* is the length of the collection.
    func lastIndex(of element: Element) -> Self.Index? {
        let range = binarySearch(equal: element, reverse: !isAscending)
        return range?.last
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

    @inlinable
    func min() -> Self.Element? {
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
    @inlinable
    func max() -> Self.Element? {
        if isAscending {
            return last
        }
        return first
    }

    /// Returns the maximum and the minimum element in the collection.
    ///
    /// - Returns: The collection's minimum/maximum element. If the collection has no
    ///   elements, returns `nil`.
    ///
    /// - Complexity: O(*1*)
    @inlinable
    func minmax() -> (min: Self.Element, max: Self.Element)? {
        guard let min = min(), let max = max() else {
            return nil
        }
        return (min: min, max: max)
    }
}
