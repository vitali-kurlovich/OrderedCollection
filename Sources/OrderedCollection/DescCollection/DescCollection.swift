//
//  DescCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

public
struct DescCollection<Element: Comparable, Buffer> where Buffer: RandomAccessCollection, Buffer.Element == Element {
    internal
    var buffer: Buffer

    internal
    init(buffer: Buffer) {
        self.buffer = buffer
    }
}

extension DescCollection: BinarySearch where Buffer.Index: SignedInteger {}

extension DescCollection: OrderedCollection where Buffer.Index: SignedInteger {
    public
    var isAscending: Bool {
        return false
    }
}

extension DescCollection {
    public
    var isEmpty: Bool { return buffer.isEmpty }

    public
    var count: Int {
        return buffer.count
    }
}

extension DescCollection {
    public
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, Element == OtherSequence.Element {
        return buffer.elementsEqual(other)
    }
}

// extension DescCollection where Buffer == ReversedCollection<[Element]> {}

extension DescCollection: BidirectionalCollection {
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
