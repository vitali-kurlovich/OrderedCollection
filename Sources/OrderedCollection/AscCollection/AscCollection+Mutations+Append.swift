//
//  AscCollection+Mutations+Append.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

extension AscCollection where Buffer: MutationCollectionAppend, Buffer: Equatable {
    public
    mutating func append(_ newElement: Element) throws {
        guard let left = self.last else {
            buffer.append(newElement)
            return
        }

        guard left <= newElement else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(newElement)
    }

    public
    mutating func append<S>(contentsOf newElements: S) throws where Element == S.Element, S: Sequence {
        var iterator = newElements.makeIterator()

        guard let right = iterator.next() else {
            return
        }

        if let left = last {
            guard left <= right else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        guard isAscOrdered(newElements) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(contentsOf: newElements)
    }

    public
    mutating func append<S>(contentsOf newElements: S) throws where Element == S.Element, S: BidirectionalCollection {
        guard let right = newElements.first else {
            return
        }

        if let left = last {
            guard left <= right else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        guard isAscOrdered(newElements) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(contentsOf: newElements)
    }

    public
    mutating func append(contentsOf newElements: AscCollection<Element, Buffer>) throws {
        guard let right = newElements.first else {
            return
        }

        guard let left = self.last else {
            buffer = newElements.buffer
            return
        }

        guard left <= right else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(contentsOf: newElements.buffer)
    }
}
