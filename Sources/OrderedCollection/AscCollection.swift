//
//  AscCollection.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

// Buffer.Indices ==  Range<Buffer.Index>

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

extension AscCollection where Buffer == [Element] {
    public
    var capacity: Int {
        return buffer.capacity
    }

    public mutating
    func reserveCapacity(_ minimumCapacity: Int) {
        buffer.reserveCapacity(minimumCapacity)
    }
}

extension AscCollection where Buffer == [Element] {
    public
    init<S>(_ sequence: S) throws where Element == S.Element, S: Sequence {
        var last: Element?
        for element in sequence {
            guard last != nil else {
                last = element
                continue
            }

            if last! > element {
                throw OrderedCollectionError.IncorrectOrderError
            }
            last = element
        }

        self.init(buffer: Array<Element>(sequence))
    }

    public
    init(_ array: [Element]) throws {
        if array.count > 2 {
            var last = array.first!
            for element in array {
                if last > element {
                    throw OrderedCollectionError.IncorrectOrderError
                }
                last = element
            }
        }

        self.init(buffer: array)
    }

    public
    init(_ collection: AscCollection<Element, [Element]>) {
        self.init(buffer: collection.buffer)
    }

    public
    init() {
        self.init(buffer: [Element]())
    }
}

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
        for element in newElements {
            try append(element: element)
        }
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

    public
    mutating func insert(_ newElement: Element, at i: Int) throws {
        let before = buffer.index(before: i)
        let after = buffer.index(after: i)

        if before >= startIndex {
            let left = self[before]
            guard left <= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        if after <= endIndex {
            let right = self[after]
            guard right >= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        buffer.insert(newElement, at: i)
    }

    public
    mutating func remove(at index: Int) -> Element {
        return buffer.remove(at: index)
    }

    public
    mutating func removeLast() -> Element {
        return buffer.removeLast()
    }
}

extension AscCollection: Equatable where Buffer: Equatable {
    public
    static func == (lhs: AscCollection, rhs: AscCollection) -> Bool {
        return lhs.buffer == rhs.buffer
    }
}

extension AscCollection where Buffer == Array<Element> {
    public
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, Element == OtherSequence.Element {
        return buffer.elementsEqual(other)
    }
}

extension AscCollection where Buffer == [Element] {
    public
    subscript(bounds: Range<Int>) -> AscCollection<Element, ArraySlice<Element>> {
        let slice = buffer[bounds]
        return AscCollection<Element, ArraySlice<Element>>(buffer: slice)
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
