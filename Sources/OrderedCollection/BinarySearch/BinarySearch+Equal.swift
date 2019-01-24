//
//  BinarySearch+Equal.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

internal
extension BinarySearch {
    @inlinable
    func binarySearchAsc(equal: Element, range: Self.Indices) -> Self.Indices? {
        guard !isEmpty, !range.isEmpty else { return nil }

        guard let leftIndex = leftAscRange(equal: equal, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }

        if equal == self[leftIndex.right] {
            guard leftIndex.left != range.last!, let rightIndex = rightAscRange(equal: equal, leftIndex: leftIndex.left + 1, rightIndex: range.last!) else {
                return (leftIndex.left ... leftIndex.left).relative(to: self) as? Self.Indices
            }

            return (leftIndex.left ... rightIndex).relative(to: self) as? Self.Indices
        } else {
            guard leftIndex.left != leftIndex.right, let rightIndex = rightAscRange(equal: equal, leftIndex: leftIndex.left + 1, rightIndex: leftIndex.right) else {
                return (leftIndex.left ... leftIndex.left).relative(to: self) as? Self.Indices
            }

            return (leftIndex.left ... rightIndex).relative(to: self) as? Self.Indices
        }
    }

    @inlinable
    func binarySearchDesc(equal: Element, range: Self.Indices) -> Self.Indices? {
        guard !isEmpty, !range.isEmpty else { return nil }

        guard let leftIndex = leftDescRange(equal: equal, leftIndex: range.first!, rightIndex: range.last!) else {
            return nil
        }

        guard let rightIndex = rightDescRange(equal: equal, leftIndex: leftIndex, rightIndex: range.last!) else {
            return nil
        }
        return (leftIndex ... rightIndex).relative(to: self) as? Self.Indices
    }
}

internal
extension BinarySearch {
    @inlinable
    func leftAscRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> (left: Self.Indices.Element, right: Self.Indices.Element)? {
        var leftIndex = leftIndex
        var rightIndex = rightIndex

        while true {
            let left = self[leftIndex]
            let right = self[rightIndex]

            if left == value {
                return (left: leftIndex, right: rightIndex)
            }

            guard right >= value, left < value else {
                return nil
            }

            if right == value, rightIndex - leftIndex <= 1 {
                return (left: rightIndex, right: rightIndex)
            }

            guard rightIndex - leftIndex >= 2 else {
                return nil
            }

            let midIndex = (leftIndex + rightIndex) / 2
            let mid = self[midIndex]

            if mid >= value {
                rightIndex = midIndex
            } else {
                leftIndex = midIndex + 1
            }
        }
    }

    @inlinable
    func rightAscRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Self.Indices.Element? {
        if self[leftIndex] != value {
            return nil
        }

        var leftIndex = leftIndex
        var rightIndex = rightIndex

        while true {
            let right = self[rightIndex]

            if right == value {
                return rightIndex
            }

            if rightIndex - leftIndex <= 1 {
                return leftIndex
            }

            let midIndex = (leftIndex + rightIndex) / 2
            let mid = self[midIndex]

            if mid <= value {
                leftIndex = midIndex
            } else {
                rightIndex = midIndex - 1
            }
        }
    }

    @inlinable
    func leftDescRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Self.Indices.Element? {
        let left = self[leftIndex]
        let right = self[rightIndex]

        if left == value {
            return leftIndex
        }

        guard left > value else {
            return nil
        }

        if right == value, rightIndex - leftIndex <= 1 {
            return rightIndex
        }

        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2

        let mid = self[midIndex]

        if mid > value {
            return leftDescRange(equal: value, leftIndex: midIndex + 1, rightIndex: rightIndex)
        }

        return leftDescRange(equal: value, leftIndex: leftIndex, rightIndex: midIndex)
    }

    @inlinable
    func rightDescRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Self.Indices.Element? {
        let right = self[rightIndex]

        if right == value {
            return rightIndex
        }

        guard right < value else {
            return nil
        }

        let left = self[leftIndex]

        if left == value, rightIndex - leftIndex <= 1 {
            return leftIndex
        }

        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid >= value {
            return rightDescRange(equal: value, leftIndex: midIndex, rightIndex: rightIndex)
        }

        return rightDescRange(equal: value, leftIndex: leftIndex, rightIndex: midIndex - 1)
    }
}

internal
extension BinarySearch {
    @inlinable
    func binarySearchAscContain(_ equal: Element, range: Self.Indices) -> Bool {
        return binarySearchAscContain(equal, leftIndex: range.first!, rightIndex: range.last!)
    }

    @inlinable
    func binarySearchAscContain(_ value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Bool {
        var leftIndex = leftIndex
        var rightIndex = rightIndex

        var left = self[leftIndex]
        var right = self[rightIndex]

        while leftIndex < rightIndex, left < value, value < right {
            let midIndex = (leftIndex + rightIndex) / 2
            let mid = self[midIndex]

            if mid >= value {
                rightIndex = midIndex
                right = self[rightIndex]
            } else {
                leftIndex = midIndex + 1
                left = self[leftIndex]
            }
        }

        return left == value || right == value
    }
}
