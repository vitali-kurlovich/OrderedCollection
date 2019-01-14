//
//  AscCollection+Internal.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

internal
func checkAscCollection<C, Element: Comparable>(_ newElements: C) throws -> Element? where C: Sequence, Element == C.Element {
    var iterator = newElements.makeIterator()

    guard var last = iterator.next() else {
        return nil
    }

    while let element = iterator.next() {
        guard last <= element else {
            throw OrderedCollectionError.IncorrectOrderError
        }
        last = element
    }

    return last
}
