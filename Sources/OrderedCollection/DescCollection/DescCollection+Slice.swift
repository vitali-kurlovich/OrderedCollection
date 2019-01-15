//
//  DescCollection+Slice.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension DescCollection where Buffer == [Element] {
    public
    subscript(bounds: Range<Int>) -> DescCollection<Element, ArraySlice<Element>> {
        let slice = buffer[bounds]
        return DescCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}
