//
//  AscCollection+Slice.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection where Buffer == [Element] {
    public
    subscript(bounds: Range<Int>) -> AscCollection<Element, ArraySlice<Element>> {
        let slice = buffer[bounds]
        return AscCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}

extension AscCollection where Buffer == ArraySlice<Element> {
    public
    subscript(bounds: Range<Int>) -> AscCollection<Element, ArraySlice<Element>> {
        let slice = buffer[bounds]
        return AscCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}
