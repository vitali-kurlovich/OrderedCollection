//
//  BinarySearch+Less.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

internal
extension BinarySearch {
    func ascRange(less: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let left = self[leftIndex]
        let right = self[rightIndex]

        if right < less {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if left >= less {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: leftIndex, rightIndex: leftIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid < less {
            guard let subrange = ascRange(less: less, leftIndex: midIndex + 1, rightIndex: rightIndex) else {
                return (leftIndex: leftIndex, rightIndex: midIndex)
            }

            return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
        }

        guard let subrange = ascRange(less: less, leftIndex: leftIndex, rightIndex: midIndex - 1) else {
            return (leftIndex: leftIndex, rightIndex: leftIndex)
        }

        return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
    }
}

internal
extension BinarySearch {
    func descRange(less: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let left = self[leftIndex]
        let right = self[rightIndex]

        if left < less {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if right >= less {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: rightIndex, rightIndex: rightIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid >= less {
            guard let subrange = descRange(less: less, leftIndex: midIndex + 1, rightIndex: rightIndex) else {
                return (leftIndex: midIndex, rightIndex: rightIndex)
            }

            return (leftIndex: subrange.leftIndex, rightIndex: rightIndex)
        }

        guard let subrange = descRange(less: less, leftIndex: leftIndex, rightIndex: midIndex) else {
            return (leftIndex: rightIndex, rightIndex: rightIndex)
        }

        return (leftIndex: subrange.leftIndex, rightIndex: rightIndex)
    }
}
