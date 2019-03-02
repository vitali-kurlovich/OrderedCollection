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

extension Array where Element: Comparable {
    public
    func sorted() -> AscArray<Element> {
        return AscArray<Element>(buffer: sorted())
    }
}

extension AscCollection where Buffer == [Element] {
    public
    init<S>(_ sequence: S) throws where Element == S.Element, S: Sequence {
        _ = try checkAscCollection(sequence)
        self.init(buffer: [Element](sequence))
    }

    public
    init<S>(_ collection: S) throws where Element == S.Element, S: Collection {
        _ = try checkAscCollection(collection)
        self.init(buffer: [Element](collection))
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

extension AscCollection where Buffer == [Element] {
    public func dropFirst() -> AscArraySlice<Element> {
        let slice = buffer.dropFirst()
        return AscArraySlice(buffer: slice)
    }

    public func dropLast() -> AscArraySlice<Element> {
        let slice = buffer.dropLast()
        return AscArraySlice(buffer: slice)
    }
}

extension AscCollection where Buffer == ArraySlice<Element> {
    public func dropFirst() -> AscArraySlice<Element> {
        let slice = buffer.dropFirst()
        return AscArraySlice(buffer: slice)
    }

    public func dropLast() -> AscArraySlice<Element> {
        let slice = buffer.dropLast()
        return AscArraySlice(buffer: slice)
    }
}
