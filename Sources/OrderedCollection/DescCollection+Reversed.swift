//
//  DescCollection+Reversed.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension DescCollection {
    public
    func reversed() -> AscCollection<Element, ReversedCollection<Buffer>> {
        let reversed = buffer.reversed()
        return AscCollection<Element, ReversedCollection<Buffer>>(buffer: reversed)
    }
}

extension AscCollection where Buffer == ReversedCollection<[Element]> {
    public
    func reversed() -> DescCollection<Element, [Element]> {
        let reversed = buffer.reversed()
        return DescCollection(buffer: reversed)
    }
}

extension AscCollection where Buffer == ReversedCollection<ArraySlice<Element>> {
    public
    func reversed() -> DescCollection<Element, ArraySlice<Element>> {
        let reversed = buffer.reversed()
        return DescCollection(buffer: reversed)
    }
}
