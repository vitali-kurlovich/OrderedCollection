//
//  OrderedCollection+Large.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

internal
extension OrderedCollection {
    func ascRange(large: Self.Element, range: Range<Int>) -> Range<Int>? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let right = self[rightIndex]
        let left = self[leftIndex]

        if left > large {
            return range
        }

        if right <= large {
            return nil
        }

        // 1, 2, 3, 4, 5, 6, 7, 8

        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        // 1 2 3 4 4 4 4 5 6 7 8

        if mid <= large {
            let findRange = Range(uncheckedBounds: (lower: midIndex + 1, upper: rightIndex))

            guard let subrange = ascRange(large: large, range: findRange) else {
                return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
            }

            return Range(uncheckedBounds: (lower: subrange.lowerBound, upper: rightIndex))
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))

        guard let subrange = ascRange(large: large, range: findRange) else {
            return Range(uncheckedBounds: (lower: midIndex, upper: midIndex))
        }

        return Range(uncheckedBounds: (lower: subrange.lowerBound, upper: rightIndex))
    }
}

internal
extension OrderedCollection {
    func descRange(large: Self.Element, range: Range<Int>) -> Range<Int>? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let right = self[rightIndex]
        let left = self[leftIndex]

        if right > large {
            return range
        }

        if left <= large {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid <= large {
            let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex - 1))

            guard let subrange = descRange(large: large, range: findRange) else {
                return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
            }

            return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
        }

        let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))

        guard let subrange = descRange(large: large, range: findRange) else {
            return Range(uncheckedBounds: (lower: midIndex, upper: midIndex))
        }

        return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
    }
}
