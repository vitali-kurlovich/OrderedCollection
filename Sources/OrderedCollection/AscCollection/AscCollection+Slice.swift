//
//  AscCollection+Slice.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

extension AscCollection where Buffer == [Element] {
    public
    subscript<R>(_ subrange: R) -> AscCollection<Element, ArraySlice<Element>> where R: RangeExpression, Index == R.Bound {
        let slice = buffer[subrange]
        return AscCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}

extension AscCollection where Buffer == ArraySlice<Element> {
    public
    subscript<R>(_ subrange: R) -> AscCollection<Element, ArraySlice<Element>> where R: RangeExpression, Index == R.Bound {
        let slice = buffer[subrange]
        return AscCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}
