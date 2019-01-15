//
//  AscCollection+Mutations+Insert.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection where Buffer == [Element] {
    public
    mutating func insert(_ newElement: Element, at i: Int) throws {
        if count == 0 {
            buffer.insert(newElement, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard newElement <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(newElement, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(newElement, at: i)
            return
        }

        let left = self[index(before: i)]
        let right = self[i]

        guard left <= newElement, newElement <= right else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(newElement, at: i)
    }

    public
    mutating func insert<C>(contentsOf newElements: C, at i: Int) throws where C: Collection, Element == C.Element {
        guard let left = newElements.first, let right = try checkAscCollection(newElements) else {
            return
        }

        if count == 0 {
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements, at: i)
    }

    public
    mutating func insert(contentsOf newElements: AscCollection, at i: Int) throws {
        guard let left = newElements.first, let right = newElements.last else {
            return
        }

        if count == 0 {
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements.buffer, at: i)
    }
}
