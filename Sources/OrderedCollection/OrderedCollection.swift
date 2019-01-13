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
    case IncorrectValueError
}

public
protocol OrderedCollection: BinarySearch {
    var isAscending: Bool { get }
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
}
