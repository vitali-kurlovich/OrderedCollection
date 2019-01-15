//
//  AscCollection+Array.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

public
typealias AscArray<Element: Comparable> = AscCollection<Element, [Element]>

public
typealias AscArraySlice<Element: Comparable> = AscCollection<Element, ArraySlice<Element>>

public
typealias ReversedAscCollection<Element: Comparable> = AscCollection<Element, ReversedCollection<[Element]>>

extension Array where Element: Comparable {
    public
    init(_ collection: AscArray<Element>) {
        self.init(collection.buffer)
    }
}

extension AscCollection where Buffer == [Element] {
    public
    init<S>(_ sequence: S) throws where Element == S.Element, S: Sequence {
        _ = try checkAscCollection(sequence)
        self.init(buffer: Array<Element>(sequence))
    }

    public
    init<S>(_ collection: S) throws where Element == S.Element, S: Collection {
        _ = try checkAscCollection(collection)
        self.init(buffer: Array<Element>(collection))
    }

    public
    init(_ array: [Element]) throws {
        _ = try checkAscCollection(array)
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
