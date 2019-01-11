//
//  OrderedArray.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/9/19.
//

import Foundation

public
struct AscArray<ElementType: Comparable> {
    private
    let buffer: [ElementType]

    public
    init(_ buffer: [ElementType]) throws {
        if buffer.count >= 2 {
            var last = buffer.first!

            for item in buffer {
                if last > item {
                    throw OrderedCollectionError.IncorrectOrderError
                }
                last = item
            }
        }

        self.buffer = buffer
    }
}

public
struct DescArray<ElementType: Comparable> {
    private
    let buffer: [ElementType]

    public
    init(_ buffer: [ElementType]) throws {
        if buffer.count >= 2 {
            var last = buffer.first!

            for item in buffer {
                if last < item {
                    throw OrderedCollectionError.IncorrectOrderError
                }
                last = item
            }
        }

        self.buffer = buffer
    }
}

extension AscArray: OrderedCollection {
    public
    typealias Element = ElementType

    public
    var isAscending: Bool {
        return true
    }

    public
    subscript(index: Int) -> ElementType {
        return buffer[index]
    }

    public
    func index(after i: Int) -> Int {
        return i + 1
    }

    public
    var startIndex: Int {
        return buffer.startIndex
    }

    public
    var endIndex: Int {
        return buffer.endIndex
    }

    public
    var count: Int {
        return buffer.count
    }
}

extension DescArray: OrderedCollection {
    public
    typealias Element = ElementType

    public
    var isAscending: Bool {
        return false
    }

    public
    subscript(index: Int) -> ElementType {
        return buffer[index]
    }

    public
    func index(after i: Int) -> Int {
        return i + 1
    }

    public
    var startIndex: Int {
        return buffer.startIndex
    }

    public
    var endIndex: Int {
        return buffer.endIndex
    }

    public
    var count: Int {
        return buffer.count
    }
}
