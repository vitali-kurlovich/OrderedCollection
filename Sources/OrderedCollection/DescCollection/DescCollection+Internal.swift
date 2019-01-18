//
//  DescCollection+Internal.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

@usableFromInline
internal
func checkDescCollection<C, Element: Comparable>(_ newElements: C) throws -> Element? where C: Sequence, Element == C.Element {
    var iterator = newElements.makeIterator()

    guard var last = iterator.next() else {
        return nil
    }

    while let element = iterator.next() {
        guard last >= element else {
            throw OrderedCollectionError.IncorrectOrderError
        }
        last = element
    }

    return last
}

@usableFromInline
internal
func isDescOrdered<C, Element: Comparable>(_ newElements: C) -> Bool where C: Sequence, Element == C.Element {
    var iterator = newElements.makeIterator()

    guard var last = iterator.next() else {
        return true
    }

    while let element = iterator.next() {
        guard last >= element else {
            return false
        }
        last = element
    }

    return true
}

@usableFromInline
internal
func isDescOrdered<C, Element: Comparable>(_ newElements: C) -> Bool where C: BidirectionalCollection, Element == C.Element {
    var iterator = newElements.makeIterator()
    guard var last = iterator.next() else {
        return true
    }

    if last < newElements.last! {
        return false
    }

    while let element = iterator.next() {
        guard last >= element else {
            return false
        }
        last = element
    }

    return true
}
