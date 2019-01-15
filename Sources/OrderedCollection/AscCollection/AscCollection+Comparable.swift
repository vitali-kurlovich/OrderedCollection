//
//  AscCollection+Comparable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

extension AscCollection: Comparable where Buffer: Equatable {
    public
    static func < (lhs: AscCollection, rhs: AscCollection) -> Bool {
        guard let left = lhs.last else {
            if rhs.first == nil {
                return false
            }
            return true
        }

        guard let right = rhs.first else {
            return false
        }
        return left < right
    }

    public
    static func <= (lhs: AscCollection, rhs: AscCollection) -> Bool {
        guard let left = lhs.last else {
            return true
        }

        guard let right = rhs.first else {
            return false
        }

        return left <= right
    }

    public
    static func >= (lhs: AscCollection, rhs: AscCollection) -> Bool {
        guard let left = lhs.last else {
            if rhs.first == nil {
                return true
            }
            return false
        }

        guard let right = rhs.first else {
            return true
        }

        return left >= right
    }

    public
    static func > (lhs: AscCollection, rhs: AscCollection) -> Bool {
        guard let left = lhs.last else {
            return false
        }

        guard let right = rhs.first else {
            return true
        }

        return left > right
    }
}
