//
//  BinarySearch+Larger.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

internal
extension BinarySearch {
    func ascRange(large: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let right = self[rightIndex]
        let left = self[leftIndex]

        if left > large {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if right <= large {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: rightIndex, rightIndex: rightIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid <= large {
            guard let subrange = ascRange(large: large, leftIndex: (midIndex + 1), rightIndex: rightIndex) else {
                return (leftIndex: rightIndex, rightIndex: rightIndex)
            }

            return (leftIndex: subrange.rightIndex, rightIndex: rightIndex)
        }

        guard let subrange = ascRange(large: large, leftIndex: leftIndex, rightIndex: midIndex) else {
            return (leftIndex: midIndex, rightIndex: midIndex)
        }

        return (leftIndex: subrange.leftIndex, rightIndex: rightIndex)
    }
}

internal
extension BinarySearch {
    func descRange(large: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let right = self[rightIndex]
        let left = self[leftIndex]

        if right > large {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if left <= large {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: leftIndex, rightIndex: leftIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid <= large {
            let findRange = leftIndex ..< (midIndex - 1)

            guard let subrange = descRange(large: large, leftIndex: leftIndex, rightIndex: (midIndex - 1)) else {
                return (leftIndex: leftIndex, rightIndex: leftIndex)
            }

            return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
        }

        let findRange = midIndex ..< rightIndex

        guard let subrange = descRange(large: large, leftIndex: midIndex, rightIndex: rightIndex) else {
            return (leftIndex: midIndex, rightIndex: midIndex)
        }

        return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
    }
}
