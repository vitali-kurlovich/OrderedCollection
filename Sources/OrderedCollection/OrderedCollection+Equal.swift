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

    func linearAscRange(equal value: Self.Element, range: Range<Int>) -> Range<Int>? {
        // let leftIndex = range.lowerBound
        // let rightIndex = range.upperBound

        var l: Int?
        for index in range.lowerBound ... range.upperBound {
            incConditional()
            incConditional()
            if self[index] == value {
                l = index
                break
            }
        }

        guard let leftIndex = l else {
            return nil
        }

        var rightIndex = leftIndex
        for index in leftIndex ... range.upperBound {
            incConditional()
            incConditional()
            if self[index] == value {
                rightIndex = index
            } else {
                break
            }
        }

        return Range(uncheckedBounds: (lower: leftIndex, upper: rightIndex))
    }
}

private
extension OrderedCollection {
    func leftAscRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        // 1 2 3 4 5 6 7 8
        let left = self[leftIndex]
        let right = self[rightIndex]

        incConditional()
        if left == value {
            return leftIndex
        }

        incConditional()
        guard right >= value, left < value else {
            return nil
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

        let findRange = Range(uncheckedBounds: (lower: midIndex + 1, upper: rightIndex))
        return leftAscRange(equal: value, range: findRange)
    }

    func rightAscRange(equal value: Self.Element, range: Range<Int>) -> Int? {
        let leftIndex = range.lowerBound
        let rightIndex = range.upperBound

        let right = self[rightIndex]
        let left = self[leftIndex]

        incConditional()
        if right == value {
            return rightIndex
        }

        // 1 2 3 4 5 6 7 8 9
        incConditional()
        guard right > value else {
            return nil
        }

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

        let findRange = Range(uncheckedBounds: (lower: leftIndex, upper: midIndex - 1))
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
