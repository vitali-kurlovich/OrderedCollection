//
//  AscArray.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

public
struct AscArray<ElementType: Comparable> {
    private
    var buffer: [ElementType]

    public
    init<S>(_ sequence: S) throws where ElementType == S.Element, S: Sequence {
        var last: ElementType?
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
    init() {
        self.init(buffer: [ElementType]())
    }

    init(buffer: [ElementType]) {
        self.buffer = buffer
    }
}

extension AscArray: OrderedCollection {
    public
    typealias Element = ElementType

    public
    typealias Index = Int

    public
    typealias Indices = Range<Int>

    public subscript(position: Int) -> ElementType {
        return buffer[position]
    }

    public func index(before i: Int) -> Int {
        return buffer.index(before: i)
    }

    public func index(after i: Int) -> Int {
        return buffer.index(after: i)
    }

    public var startIndex: Int {
        return buffer.startIndex
    }

    public var endIndex: Int {
        return buffer.endIndex
    }

    public var indices: Range<Int> {
        return buffer.indices
    }

    public
    var isAscending: Bool {
        return true
    }
}

extension AscArray {
    public mutating
    func append(element: Element) throws {
        guard let last = self.last else {
            buffer.append(element)
            return
        }

        guard last <= element else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(element)
    }
}

extension AscArray: Equatable {
    public
    static func == (lhs: AscArray<Element>, rhs: AscArray<Element>) -> Bool {
        return lhs.buffer == rhs.buffer
    }

    public
    static func == (lhs: Array<Element>, rhs: AscArray<Element>) -> Bool {
        return lhs == rhs.buffer
    }

    public
    static func == (lhs: AscArray<Element>, rhs: Array<Element>) -> Bool {
        return lhs.buffer == rhs
    }
}

extension AscArray {
    public
    var count: Int {
        return buffer.count
    }
}
