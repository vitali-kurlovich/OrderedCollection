//
//  AscCollection+Equatable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection: Equatable where Buffer: Equatable {
    public
    static func == (lhs: AscCollection, rhs: AscCollection) -> Bool {
        return lhs.buffer == rhs.buffer
    }
}

extension AscCollection where Buffer: Equatable {
    public
    static func == (lhs: AscCollection, rhs: Buffer) -> Bool {
        return lhs.buffer == rhs
    }

    public
    static func == (lhs: Buffer, rhs: AscCollection) -> Bool {
        return lhs == rhs.buffer
    }
}

extension AscCollection {
    public
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence: Sequence, Element == OtherSequence.Element {
        return buffer.elementsEqual(other)
    }
}
