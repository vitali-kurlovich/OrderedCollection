//
//  DescCollection+Array.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

public
typealias DescArray<Element: Comparable> = DescCollection<Element, [Element]>

public
typealias DescArraySlice<Element: Comparable> = DescCollection<Element, ArraySlice<Element>>

public
typealias ReversedDescCollection<Element: Comparable> = DescCollection<Element, ReversedCollection<[Element]>>

extension Array where Element: Comparable {
    public
    init(_ collection: DescArray<Element>) {
        self.init(collection.buffer)
    }
}

extension DescCollection where Buffer == [Element] {
    public
    var capacity: Int {
        return buffer.capacity
    }

    public mutating
    func reserveCapacity(_ minimumCapacity: Int) {
        buffer.reserveCapacity(minimumCapacity)
    }
}

extension DescCollection where Buffer == [Element] {
    public
    init<S>(_ sequence: S) throws where Element == S.Element, S: Sequence {
        _ = try checkDescCollection(sequence)
        self.init(buffer: Array<Element>(sequence))
    }

    public
    init<S>(_ collection: S) throws where Element == S.Element, S: Collection {
        _ = try checkDescCollection(collection)
        self.init(buffer: Array<Element>(collection))
    }

    public
    init(_ array: [Element]) throws {
        _ = try checkDescCollection(array)
        self.init(buffer: array)
    }

    public
    init(_ collection: DescCollection<Element, [Element]>) {
        self.init(buffer: collection.buffer)
    }

    public
    init() {
        self.init(buffer: [Element]())
    }
}

extension DescCollection where Buffer == [Element] {
    public
    subscript(bounds: Range<Int>) -> DescCollection<Element, ArraySlice<Element>> {
        let slice = buffer[bounds]
        return DescCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}
