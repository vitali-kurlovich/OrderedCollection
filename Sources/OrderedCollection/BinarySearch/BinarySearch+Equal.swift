//
//  BinarySearch+Equal.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

internal
extension BinarySearch {
    @usableFromInline
    func leftRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element, reverse: Bool) -> Self.Indices.Element? {
        if !reverse {
            return leftAscRange(equal: value, leftIndex: leftIndex, rightIndex: rightIndex)
        }
        return leftDescRange(equal: value, leftIndex: leftIndex, rightIndex: rightIndex)
    }

    @usableFromInline
    func rightRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element, reverse: Bool) -> Self.Indices.Element? {
        if !reverse {
            return rightAscRange(equal: value, leftIndex: leftIndex, rightIndex: rightIndex)
        }
        return rightDescRange(equal: value, leftIndex: leftIndex, rightIndex: rightIndex)
    }
}

private
extension BinarySearch {
    func leftAscRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Self.Indices.Element? {
        let left = self[leftIndex]
        let right = self[rightIndex]

        if left == value {
            return leftIndex
        }

        guard right >= value, left < value else {
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

        if mid >= value {
            return leftAscRange(equal: value, leftIndex: leftIndex, rightIndex: midIndex)
        }

        return leftAscRange(equal: value, leftIndex: midIndex + 1, rightIndex: rightIndex)
    }

    func rightAscRange(equal value: Self.Element, leftIndex: Self.Indices.Element, rightIndex: Self.Indices.Element) -> Self.Indices.Element? {
        let right = self[rightIndex]
        let left = self[leftIndex]

        if right == value {
            return rightIndex
        }

        guard right > value else {
            return nil
        }

        if left == value, rightIndex - leftIndex <= 1 {
            return leftIndex
        }

        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        if mid <= value {
            return rightAscRange(equal: value, leftIndex: midIndex, rightIndex: rightIndex)
        }

        return rightAscRange(equal: value, leftIndex: leftIndex, rightIndex: (midIndex - 1))
    }

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
