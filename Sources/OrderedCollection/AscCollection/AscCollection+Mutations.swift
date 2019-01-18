//
//  AscCollection+Mutations.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

extension AscCollection: MutationCollectionCapacity where Buffer: MutationCollectionCapacity {
    public
    var capacity: Int {
        return buffer.capacity
    }

    public mutating
    func reserveCapacity(_ minimumCapacity: Int) {
        buffer.reserveCapacity(minimumCapacity)
    }
}
