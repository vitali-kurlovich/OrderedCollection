//
//  BinarySearch.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

public
protocol BinarySearch: BidirectionalCollection where Element: Comparable,
    Self.Index: SignedInteger {}

extension BinarySearch {
    public
    func binarySearchContain(_ equal: Element, range: Self.Indices, reverse: Bool = false) -> Bool {
        guard !isEmpty, !range.isEmpty else {
            return false
        }

        if reverse {
            return binarySearchDesc(equal: equal, range: range) != nil
        }
        return binarySearchAscContain(equal, range: range)
    }

    @inlinable
    public
    func binarySearchContain(_ equal: Element, reverse: Bool = false) -> Bool {
        return binarySearchContain(equal, range: indices, reverse: reverse)
    }
}

extension BinarySearch {
    @inlinable
    public
    func binarySearch(equal: Element, reverse: Bool = false) -> Self.Indices? {
        return binarySearch(equal: equal, range: indices, reverse: reverse)
    }

    public
    func binarySearch(equal: Element, range: Self.Indices, reverse: Bool = false) -> Self.Indices? {
        if reverse {
            return binarySearchDesc(equal: equal, range: range)
        }
        return binarySearchAsc(equal: equal, range: range)
    }

    @inlinable
    public
    func binarySearch(less: Element, reverse: Bool = false) -> Self.Indices? {
        return binarySearch(less: less, range: indices, reverse: reverse)
    }

    public
    func binarySearch(less: Element, range: Self.Indices, reverse: Bool = false) -> Self.Indices? {
        guard !isEmpty, !range.isEmpty else { return nil }

        if range.first == range.last {
            if self[range.first!] < less {
                return range
            }
            return nil
        }

        if !reverse {
            guard let result = ascRange(less: less, leftIndex: range.first!, rightIndex: range.last!) else {
                return nil
            }
            return (result.leftIndex ... result.rightIndex).relative(to: self) as? Self.Indices
        }

        guard let result = descRange(less: less, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }
        return (result.leftIndex ... result.rightIndex).relative(to: self) as? Self.Indices
    }

    @inlinable
    public
    func binarySearch(greater: Element, reverse: Bool = false) -> Self.Indices? {
        return binarySearch(greater: greater, range: indices, reverse: reverse)
    }

    public
    func binarySearch(greater: Element, range: Self.Indices, reverse: Bool = false) -> Self.Indices? {
        guard !isEmpty, !range.isEmpty else { return nil }
        if range.first == range.last {
            if self[range.last!] > greater {
                return range
            }
            return nil
        }

        if !reverse {
            guard let result = ascRange(greater: greater, leftIndex: range.first!, rightIndex: range.last!) else {
                return nil
            }
            return (result.leftIndex ... result.rightIndex).relative(to: self) as? Self.Indices
        }

        guard let result = descRange(greater: greater, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }

        return (result.leftIndex ... result.rightIndex).relative(to: self) as? Self.Indices
    }
}
