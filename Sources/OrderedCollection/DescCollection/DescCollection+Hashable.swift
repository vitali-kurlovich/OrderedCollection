//
//  DescCollection+Hashable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension DescCollection: Hashable where Buffer: Hashable {
    public var hashValue: Int { return buffer.hashValue }

    public func hash(into hasher: inout Hasher) {
        buffer.hash(into: &hasher)
    }
}
