//
//  DescCollection+Op.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/20/19.
//

extension DescCollection {
    public
    static func + <Other>(lhs: DescCollection, rhs: Other) throws -> DescArray<Element> where Other: Sequence, Element == Other.Element {
        var iterator = rhs.makeIterator()

        guard let right = iterator.next() else {
            return DescArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            guard isDescOrdered(rhs) else {
                throw OrderedCollectionError.IncorrectValueError
            }

            return DescArray<Element>(buffer: Array(rhs))
        }

        guard left >= right, isDescOrdered(rhs) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs)
        return DescArray<Element>(buffer: buffer)
    }

    public
    static func + <Other>(lhs: DescCollection, rhs: Other) throws -> DescArray<Element> where Other: BidirectionalCollection, Element == Other.Element {
        guard let right = rhs.first else {
            return DescArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            guard isDescOrdered(rhs) else {
                throw OrderedCollectionError.IncorrectValueError
            }
            return DescArray<Element>(buffer: Array(rhs))
        }

        guard left >= right, isDescOrdered(rhs) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs)
        return DescArray<Element>(buffer: buffer)
    }

    public
    static func + (lhs: DescCollection, rhs: DescCollection) throws -> DescArray<Element> {
        guard let right = rhs.first else {
            return DescArray<Element>(buffer: Array(lhs.buffer))
        }

        guard let left = lhs.last else {
            return DescArray<Element>(buffer: Array(rhs.buffer))
        }

        guard left >= right else {
            throw OrderedCollectionError.IncorrectValueError
        }

        var buffer = Array(lhs.buffer)
        buffer.append(contentsOf: rhs.buffer)
        return DescArray<Element>(buffer: buffer)
    }
}

extension DescCollection where Buffer: MutationCollectionAppend, Buffer: Equatable {
    public
    static func += <Other>(lhs: inout DescCollection, rhs: Other) throws where Other: Sequence, Element == Other.Element {
        try lhs.append(contentsOf: rhs)
    }

    public
    static func += <Other>(lhs: inout DescCollection, rhs: Other) throws where Other: BidirectionalCollection, Element == Other.Element {
        try lhs.append(contentsOf: rhs)
    }

    public
    static func += (lhs: inout DescCollection, rhs: DescCollection) throws {
        try lhs.append(contentsOf: rhs)
    }
}
