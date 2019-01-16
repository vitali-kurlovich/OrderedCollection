//
//  DescCollection+Mutations+Remove.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

extension DescCollection: MutationCollectionRemove where Buffer: MutationCollectionRemove {
    public
    mutating func remove(at index: Int) -> Element {
        return buffer.remove(at: index)
    }

    public
    mutating func removeSubrange(_ bounds: Range<Int>) {
        buffer.removeSubrange(bounds)
    }

    public
    mutating func removeFirst(_ k: Int) {
        buffer.removeFirst(k)
    }

    public
    mutating func removeFirst() -> Element {
        return buffer.removeFirst()
    }

    public
    mutating func removeLast() -> Element {
        return buffer.removeLast()
    }

    public
    mutating func removeLast(_ k: Int) {
        buffer.removeLast(k)
    }

    public
    mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        buffer.removeAll(keepingCapacity: keepCapacity)
    }

    public
    mutating func removeSubrange<R>(_ bounds: R) where R: RangeExpression, Array<Element>.Index == R.Bound {
        buffer.removeSubrange(bounds)
    }
}
