//
//  AscCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

public
struct AscCollection<Element: Comparable, Buffer> where Buffer: RandomAccessCollection, Buffer.Element == Element {
    internal
    var buffer: Buffer

    internal
    init(buffer: Buffer) {
        self.buffer = buffer
    }
}

extension AscCollection: BinarySearch where Buffer.Index: SignedInteger {}

extension AscCollection: OrderedCollection where Buffer.Index: SignedInteger {
    public
    var isAscending: Bool {
        return true
    }
}



extension AscCollection {
    public
    var isEmpty: Bool { return buffer.isEmpty }

    public
    var count: Int {
        return buffer.count
    }
}

extension AscCollection: Equatable where Buffer: Equatable {
    public
    static func == (lhs: AscCollection, rhs: AscCollection) -> Bool {
        return lhs.buffer == rhs.buffer
    }
}

extension AscCollection {
    public
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, Element == OtherSequence.Element {
        return buffer.elementsEqual(other)
    }
}

// extension AscCollection where Buffer == ReversedCollection<[Element]> {}

extension AscCollection: BidirectionalCollection {
    public
    typealias Element = Buffer.Element

    public
    typealias SubSequence = Buffer.SubSequence

    public
    typealias Index = Buffer.Index

    public
    typealias Indices = Buffer.Indices

    public subscript(position: Index) -> Element {
        return buffer[position]
    }

    public func index(before i: Index) -> Index {
        return buffer.index(before: i)
    }

    public func index(after i: Index) -> Index {
        return buffer.index(after: i)
    }

    public var startIndex: Index {
        return buffer.startIndex
    }

    public var endIndex: Index {
        return buffer.endIndex
    }

    public var indices: Indices {
        return buffer.indices
    }
}
