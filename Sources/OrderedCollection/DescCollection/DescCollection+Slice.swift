//
//  DescCollection+Slice.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

extension DescCollection where Buffer == [Element] {
    public
    subscript<R>(_ subrange: R) -> DescCollection<Element, ArraySlice<Element>> where R: RangeExpression, Index == R.Bound {
        let slice = buffer[subrange]
        return DescCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}

extension DescCollection where Buffer == ArraySlice<Element> {
    public
    subscript<R>(_ subrange: R) -> DescCollection<Element, ArraySlice<Element>> where R: RangeExpression, Index == R.Bound {
        let slice = buffer[subrange]
        return DescCollection<Element, ArraySlice<Element>>(buffer: slice)
    }
}
