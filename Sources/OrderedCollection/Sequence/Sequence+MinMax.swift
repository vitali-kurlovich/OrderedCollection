//
//  Sequence+MinMax.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension Sequence where Self.Element: Comparable {
    @inlinable public
    func minmax() -> (min: Self.Element, max: Self.Element)? {
        var iterator = makeIterator()

        guard var min = iterator.next() else {
            return nil
        }

        var max = min

        while let current = iterator.next() {
            if min > current {
                min = current
            } else if max < current {
                max = current
            }
        }

        return (min: min, max: max)
    }
}
