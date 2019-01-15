//
//  DescCollection+Equatable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension DescCollection: Equatable where Buffer: Equatable {
    public
    static func == (lhs: DescCollection, rhs: DescCollection) -> Bool {
        return lhs.buffer == rhs.buffer
    }
}

extension DescCollection where Buffer: Equatable {
    public
    static func == (lhs: DescCollection, rhs: Buffer) -> Bool {
        return lhs.buffer == rhs
    }

    public
    static func == (lhs: Buffer, rhs: DescCollection) -> Bool {
        return lhs == rhs.buffer
    }
}

extension DescCollection {
    public
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, Element == OtherSequence.Element {
        return buffer.elementsEqual(other)
    }
}
