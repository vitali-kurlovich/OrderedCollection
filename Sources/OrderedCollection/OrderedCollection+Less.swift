//
//  OrderedCollection+Less.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

internal
extension OrderedCollection {
    func ascRange(less: Self.Element, range: Range<Int>) -> Range<Int>? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let left = self[leftIndex]
        let right = self[rightIndex]

        if right < less {
            return range
        }

        if left >= less {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid < less {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            guard let subrange = ascRange(less: less, range: findRange) else {
                return Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
            }

            return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        guard let subrange = ascRange(less: less, range: findRange) else {
            return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
        }

        return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
    }
}

internal
extension OrderedCollection {
    func descRange(less: Self.Element, range: Range<Int>) -> Range<Int>? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let left = self[leftIndex]
        let right = self[rightIndex]

        if left < less {
            return range
        }

        if right >= less {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        // 8, 7, 6, 5, 4, 3, 2, 1

        if mid >= less {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            guard let subrange = descRange(less: less, range: findRange) else {
                return Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            }

            return Range(uncheckedBounds: (lower: subrange.lowerBound, upper: rightIndex))
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        guard let subrange = descRange(less: less, range: findRange) else {
            return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
        }

        return Range(uncheckedBounds: (lower: subrange.lowerBound, upper: rightIndex))
    }
}
