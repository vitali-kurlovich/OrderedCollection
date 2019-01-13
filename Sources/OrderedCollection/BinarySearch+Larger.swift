//
//  BinarySearch+Larger.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

internal
extension BinarySearch {
    func ascRange(greater: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let right = self[rightIndex]
        let left = self[leftIndex]

        // 1 2 3 4 5 6 7 8
        if left > greater {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if right <= greater {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: rightIndex, rightIndex: rightIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        // 1 2 3 4 5 6 7 8

        if mid <= greater {
            guard let subrange = ascRange(greater: greater, leftIndex: (midIndex + 1), rightIndex: rightIndex) else {
                return (leftIndex: rightIndex, rightIndex: rightIndex)
            }

            return (leftIndex: subrange.leftIndex, rightIndex: rightIndex)
        }

        guard let subrange = ascRange(greater: greater, leftIndex: leftIndex, rightIndex: midIndex) else {
            return (leftIndex: midIndex, rightIndex: midIndex)
        }

        return (leftIndex: subrange.leftIndex, rightIndex: rightIndex)
    }
}

internal
extension BinarySearch {
    func descRange(greater: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element)? {
        let right = self[rightIndex]
        let left = self[leftIndex]

        if right > greater {
            return (leftIndex: leftIndex, rightIndex: rightIndex)
        }

        if left <= greater {
            return nil
        }

        guard rightIndex - leftIndex >= 2 else {
            return (leftIndex: leftIndex, rightIndex: leftIndex)
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid <= greater {
            guard let subrange = descRange(greater: greater, leftIndex: leftIndex, rightIndex: (midIndex - 1)) else {
                return (leftIndex: leftIndex, rightIndex: leftIndex)
            }

            return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
        }

        guard let subrange = descRange(greater: greater, leftIndex: midIndex, rightIndex: rightIndex) else {
            return (leftIndex: midIndex, rightIndex: midIndex)
        }

        return (leftIndex: leftIndex, rightIndex: subrange.rightIndex)
    }
}
