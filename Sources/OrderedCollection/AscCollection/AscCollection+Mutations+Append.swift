//
//  AscCollection+Mutations+Append.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection where Buffer == [Element] {
    public
    mutating func append(element: Element) throws {
        guard let last = self.last else {
            buffer.append(element)
            return
        }

        guard last <= element else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(element)
    }

    public
    mutating func append<S>(contentsOf newElements: S) throws where Element == S.Element, S: Sequence {
        var iterator = newElements.makeIterator()

        guard let left = iterator.next() else {
            return
        }

        if let last = last {
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        _ = try checkAscCollection(newElements)

        buffer.append(contentsOf: newElements)
    }

    public
    mutating func append(contentsOf newElements: AscCollection) throws {
        guard newElements.count > 0 else { return }

        if count == 0 {
            buffer = newElements.buffer
            return
        }

        let first = newElements.first!
        guard last! <= first else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(contentsOf: newElements.buffer)
    }
}
