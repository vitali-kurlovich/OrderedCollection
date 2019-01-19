//
//  DescCollection+Sort.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

extension DescCollection {
    public func sorted() -> AscCollection<Element, ReversedCollection<Buffer>> {
        return reversed()
    }
}

extension DescCollection where Buffer == ReversedCollection<[Element]> {
    public func sorted() -> AscCollection<Element, [Element]> {
        return reversed()
    }
}

extension DescCollection where Buffer == ReversedCollection<ArraySlice<Element>> {
    public func sorted() -> AscCollection<Element, ArraySlice<Element>> {
        return reversed()
    }
}
