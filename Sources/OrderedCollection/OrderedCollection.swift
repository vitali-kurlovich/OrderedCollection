//
//  OrderedCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/8/19.
//

import Foundation

public
enum OrderedCollectionError: Error {
    case IncorrectOrderError
}

public
protocol OrderedCollection: BinarySearch {
    // associatedtype Element
    var isAscending: Bool { get }

    // subscript(_: Int) -> Self.Element { get }
}

public
extension OrderedCollection {
    func range(equal: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(equal: equal, range: range, reverse: !isAscending)
    }

    func range(less: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(less: less, range: range, reverse: !isAscending)
    }

    func range(large: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        return binarySearch(large: large, range: range, reverse: !isAscending)
    }

    /*
     func range(equal value: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
     guard count > 0 else { return nil }

     var range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

     guard let leftIndex = leftRange(equal: value, range: range) else {
     return nil
     }

     range = Range(uncheckedBounds: (lower: leftIndex, upper: range.upperBound))

     guard let rightIndex = rightRange(equal: value, range: range) else {
     return nil
     }

     return Range(uncheckedBounds: (lower: leftIndex, upper: rightIndex))
     }

     func range(less: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
     guard count > 0 else { return nil }

     let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

     if range.lowerBound == range.upperBound {
     if self[0] < less {
     return range
     }
     return nil
     }

     if isAscending {
     return ascRange(less: less, range: range)
     }
     return descRange(less: less, range: range)
     }

     func range(large: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
     guard count > 0 else { return nil }

     let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

     if range.lowerBound == range.upperBound {
     if self[0] > large {
     return range
     }
     return nil
     }

     if isAscending {
     return ascRange(large: large, range: range)
     }

     return descRange(large: large, range: range)
     }
     */
}
