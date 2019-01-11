//
//  OrderedCollection+Equal.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

internal
extension OrderedCollection {
    func leftRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        incConditional()
        if isAscending {
            return leftAscRange(equal: value, range: range)
        }
        return leftDescRange(equal: value, range: range)
    }

    func rightRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        incConditional()
        if isAscending {
            return rightAscRange(equal: value, range: range)
        }
        return rightDescRange(equal: value, range: range)
    }
}

private
extension OrderedCollection {
    func leftLineadAscRange(equal _: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let left = self[leftIndex]
        let right = self[rightIndex]

        return nil
    }

    func leftAscRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        // 1 2 3 4 5 6 7 8
        let left = self[leftIndex]

        incConditional()
        if left == value {
            return leftIndex
        }

        incConditional()
        let right = self[rightIndex]

        guard right >= value, left < value else {
            return nil
        }

        incConditional()
        if rightIndex - leftIndex < 50 {
            //  return leftLineadAscRange(equal:value, range:range)
        }

        incConditional()
        if right == value, rightIndex - leftIndex <= 1 {
            return rightIndex
        }

        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2

        let mid = self[midIndex]

        incConditional()
        if mid >= value {
            let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
            return leftAscRange(equal: value, range: findRange)
        }

        let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
        return leftAscRange(equal: value, range: findRange)
    }

    func rightAscRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let right = self[rightIndex]

        incConditional()
        if right == value {
            return rightIndex
        }

        incConditional()
        guard right > value else {
            return nil
        }

        let left = self[leftIndex]

        incConditional()
        if left == value, rightIndex - leftIndex <= 1 {
            return leftIndex
        }

        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2
        let mid = self[midIndex]

        incConditional()
        if mid <= value {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            return rightAscRange(equal: value, range: findRange)
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        return rightAscRange(equal: value, range: findRange)
    }

    func leftDescRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let left = self[leftIndex]

        incConditional()
        if left == value {
            return leftIndex
        }

        incConditional()
        guard left > value else {
            return nil
        }

        let right = self[rightIndex]

        incConditional()
        if right == value, rightIndex - leftIndex <= 1 {
            return rightIndex
        }

        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2

        let mid = self[midIndex]

        incConditional()
        if mid > value {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            return leftDescRange(equal: value, range: findRange)
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        return leftDescRange(equal: value, range: findRange)
    }

    func rightDescRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let right = self[rightIndex]

        incConditional()
        if right == value {
            return rightIndex
        }

        incConditional()
        guard right < value else {
            return nil
        }

        let left = self[leftIndex]

        incConditional()
        if left == value, rightIndex - leftIndex <= 1 {
            return leftIndex
        }

        incConditional()
        guard rightIndex - leftIndex >= 2 else {
            return nil
        }

        let midIndex = (leftIndex + rightIndex) / 2

        let mid = self[midIndex]

        incConditional()
        if mid >= value {
            let findRange = Range(uncheckedBounds: (lower: midIndex, upper: rightIndex))
            return rightDescRange(equal: value, range: findRange)
        }

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex))
        return rightDescRange(equal: value, range: findRange)
    }
}
