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
}

public
protocol OrderedCollection: Collection where Self.Element: Comparable {
    associatedtype Element
    var isAscending: Bool { get }

    subscript(_: Int) -> Self.Element { get }
}

public
extension OrderedCollection {
    func range(equal value: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        incConditional()
        guard count > 0 else { return nil }

        incConditional()
        var range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        incConditional()
        guard let leftIndex = leftRange(equal: value, range: range) else {
            return nil
        }

        range = Range(uncheckedBounds: (lower: leftIndex, upper: range.upperBound))

        incConditional()
        guard let rightIndex = rightRange(equal: value, range: range) else {
            return nil
        }

        return Range(uncheckedBounds: (lower: leftIndex, upper: rightIndex))
    }

    func range(less: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        incConditional()
        guard count > 0 else { return nil }

        incConditional()
        let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        incConditional()
        if range.lowerBound == range.upperBound {
            incConditional()
            if self[0] < less {
                return range
            }
            return nil
        }

        incConditional()
        if isAscending {
            return ascRange(less: less, range: range)
        }
        return descRange(less: less, range: range)
    }

    func range(large: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        incConditional()
        guard count > 0 else { return nil }

        incConditional()
        let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        incConditional()
        if range.lowerBound == range.upperBound {
            incConditional()
            if self[0] > large {
                return range
            }
            return nil
        }

        incConditional()
        if isAscending {
            return ascRange(large: large, range: range)
        }

        return descRange(large: large, range: range)
    }
}
