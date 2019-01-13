//
//  DescArray.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

public
struct DescArray<ElementType: Comparable> {
    private
    var buffer: [ElementType]

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

extension DescArray: OrderedCollection {
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
    var count: Int {
        return buffer.count
    }

    public
    var isAscending: Bool {
        return false
    }
}
