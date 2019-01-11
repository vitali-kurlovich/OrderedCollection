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

        incConditional()
        if left > large {
            return range
        }

        incConditional()
        if right <= large {
            return nil
        }

        // 1, 2, 3, 4, 5, 6, 7, 8
        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        incConditional()
        if mid <= large {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            incConditional()
            guard let subrange = ascRange(large: large, range: findRange) else {
                return Range(uncheckedBounds: (lower: rightIndex, upper: rightIndex))
            }

            return Range(uncheckedBounds: (lower: subrange.lowerBound, upper: rightIndex))
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        incConditional()
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
        incConditional()
        if right > large {
            return range
        }
        incConditional()
        if left <= large {
            return nil
        }

        // 8, 7, 6, 5, 4, 3, 2, 1
        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]
        incConditional()
        if mid <= large {
            let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
            incConditional()
            guard let subrange = descRange(large: large, range: findRange) else {
                return Range(uncheckedBounds: (lower: leftIndex, upper: leftIndex))
            }

            return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
        }

        let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
        incConditional()
        guard let subrange = descRange(large: large, range: findRange) else {
            return Range(uncheckedBounds: (lower: midIndex, upper: midIndex))
        }

        return Range(uncheckedBounds: (lower: leftIndex, upper: subrange.upperBound))
    }
}
