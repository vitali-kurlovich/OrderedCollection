//
//  AscCollection+Reversed.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

extension AscCollection {
    /// Returns a descending ordered collection
    ///
    /// - Complexity: O(1)
    public
    func reversed() -> DescCollection<Element, ReversedCollection<Buffer>> {
        let reversed = buffer.reversed()
        return DescCollection(buffer: reversed)
    }
}

extension DescCollection where Buffer == ReversedCollection<[Element]> {
    /// Returns a ascending ordered collection
    ///
    /// - Complexity: O(1)
    public
    func reversed() -> AscCollection<Element, [Element]> {
        let reversed = buffer.reversed()
        return AscCollection(buffer: reversed)
    }
}

extension DescCollection where Buffer == ReversedCollection<ArraySlice<Element>> {
    /// Returns a ascending ordered collection
    ///
    /// - Complexity: O(1)
    public
    func reversed() -> AscCollection<Element, ArraySlice<Element>> {
        let reversed = buffer.reversed()
        return AscCollection(buffer: reversed)
    }
}
