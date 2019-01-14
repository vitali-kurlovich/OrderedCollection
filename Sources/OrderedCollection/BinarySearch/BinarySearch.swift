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
    func binarySearch(equal: Element, range: Self.Indices? = nil, reverse: Bool = false) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices

        guard let leftIndex = leftRange(equal: equal, leftIndex: range.first!, rightIndex: range.last!, reverse: reverse) else {
            return nil
        }

        guard let rightIndex = rightRange(equal: equal, leftIndex: leftIndex, rightIndex: range.last!, reverse: reverse) else {
            return nil
        }

        return leftIndex ..< (rightIndex + 1) as? Self.Indices
    }

    public
    func binarySearch(less: Element, range: Self.Indices? = nil, reverse: Bool = false) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices
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
            return result.leftIndex ..< (result.rightIndex + 1) as? Self.Indices
        }

        guard let result = descRange(less: less, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }
        return result.leftIndex ..< (result.rightIndex + 1) as? Self.Indices
    }

    public
    func binarySearch(greater: Element, range: Self.Indices? = nil, reverse: Bool = false) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices
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
            return result.leftIndex ..< (result.rightIndex + 1) as? Self.Indices
        }

        guard let result = descRange(greater: greater, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }

        return result.leftIndex ..< (result.rightIndex + 1) as? Self.Indices
    }
}
