//
//  AscCollection+Op.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

public
extension AscCollection {
    static func + <Other>(lhs: AscCollection, rhs: Other) throws -> AscArray<Element> where Other: Sequence, Element == Other.Element {
        var iterator = rhs.makeIterator()

        guard let right = iterator.next() else {
            return AscArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            guard isAscOrdered(rhs) else {
                throw OrderedCollectionError.IncorrectValueError
            }

            return AscArray<Element>(buffer: Array(rhs))
        }

        guard left <= right, isAscOrdered(rhs) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs)
        return AscArray<Element>(buffer: buffer)
    }

    static func + <Other>(lhs: AscCollection, rhs: Other) throws -> AscArray<Element> where Other: BidirectionalCollection, Element == Other.Element {
        guard let right = rhs.first else {
            return AscArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            guard isAscOrdered(rhs) else {
                throw OrderedCollectionError.IncorrectValueError
            }
            return AscArray<Element>(buffer: Array(rhs))
        }

        guard left <= right, isAscOrdered(rhs) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs)
        return AscArray<Element>(buffer: buffer)
    }

    static func + (lhs: AscCollection, rhs: AscCollection) throws -> AscArray<Element> {
        guard let right = rhs.first else {
            return AscArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            return AscArray<Element>(buffer: Array(rhs.buffer))
        }

        guard left <= right else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs.buffer)
        return AscArray<Element>(buffer: buffer)
    }
}

public
extension AscCollection where Buffer: MutationCollectionAppend, Buffer: Equatable {
    static func += <Other>(lhs: inout AscCollection, rhs: Other) throws where Other: Sequence, Element == Other.Element {
        try lhs.append(contentsOf: rhs)
    }

    static func += <Other>(lhs: inout AscCollection, rhs: Other) throws where Other: BidirectionalCollection, Element == Other.Element {
        try lhs.append(contentsOf: rhs)
    }

    static func += (lhs: inout AscCollection, rhs: AscCollection) throws {
        try lhs.append(contentsOf: rhs)
    }
}
