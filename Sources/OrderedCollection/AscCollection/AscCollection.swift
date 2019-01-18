//
//  AscCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

public
struct AscCollection<Element: Comparable, Buffer> where Buffer: RandomAccessCollection, Buffer.Element == Element {
    @usableFromInline
    internal var buffer: Buffer

    internal
    init(buffer: Buffer) {
        self.buffer = buffer
    }
}

extension AscCollection: BinarySearch where Buffer.Index: SignedInteger {}

extension AscCollection: OrderedCollection where Buffer.Index: SignedInteger {
    @inlinable
    public var isAscending: Bool {
        return true
    }
}

extension AscCollection {
    @inlinable
    public var isEmpty: Bool { return buffer.isEmpty }

    @inlinable
    public var count: Int {
        return buffer.count
    }
}

extension AscCollection: BidirectionalCollection {
    public
    typealias Element = Buffer.Element

    public
    typealias SubSequence = Buffer.SubSequence

    public
    typealias Index = Buffer.Index

    public
    typealias Indices = Buffer.Indices

    @inlinable
    public subscript(position: Index) -> Element {
        return buffer[position]
    }

    @inlinable
    public func index(before i: Index) -> Index {
        return buffer.index(before: i)
    }

    @inlinable
    public func index(after i: Index) -> Index {
        return buffer.index(after: i)
    }

    @inlinable
    public var startIndex: Index {
        return buffer.startIndex
    }

    @inlinable
    public var endIndex: Index {
        return buffer.endIndex
    }

    @inlinable
    public var indices: Indices {
        return buffer.indices
    }
}
