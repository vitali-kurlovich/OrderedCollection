//
//  AscCollection+Equatable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection: Equatable where Buffer: Equatable {
    public
    static func == (lhs: AscCollection, rhs: AscCollection) -> Bool {
        return lhs.buffer == rhs.buffer
    }
}
