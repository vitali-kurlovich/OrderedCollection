//
//  AscCollection+Mutations+Remove.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation


extension AscCollection where Buffer:MutationCollectionRemove {
    public
    mutating func remove(at index: Int) -> Element {
        return buffer.remove(at: index)
    }
    

    public
    mutating func removeLast() -> Element {
        return buffer.removeLast()
    }
    
    public
    mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        buffer.removeAll(keepingCapacity: keepCapacity)
    }
}


