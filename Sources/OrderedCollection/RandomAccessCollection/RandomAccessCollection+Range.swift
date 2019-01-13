//
//  RandomAccessCollection+Range.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

extension BidirectionalCollection
    where Self.Element: Comparable,
    Self.Index: SignedInteger,
    Self.Index.Stride == Self.Index {
    public
    func range(equal value: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices

        var l: Self.Indices.Element?
        for index in range {
            if self[index] == value {
                l = index
                break
            }
        }

        guard let left = l else {
            return nil
        }

        var right = left
        for index in left ... range.last! {
            if self[index] == value {
                right = index
            } else {
                break
            }
        }

        return left ..< (right + 1) as? Self.Indices
    }

    public
    func range(less: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices

        var left: Self.Index?
        var right: Self.Index?

        for index in range.first! ... range.last! {
            let value = self[index]

            if value < less {
                if left == nil {
                    left = index
                    right = index
                } else {
                    right = index
                }
            } else {
                if left != nil, right != nil {
                    break
                }
            }
        }

        guard let leftIndex = left, let rightIndex = right else {
            return nil
        }

        return leftIndex ..< (rightIndex + 1) as? Self.Indices
    }

    public
    func range(large: Self.Element, range: Self.Indices? = nil) -> Self.Indices? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : indices

        var left: Self.Index?
        var right: Self.Index?

        for index in range.first! ... range.last! {
            let value = self[index]

            if value > large {
                if left == nil {
                    left = index
                    right = index
                } else {
                    right = index
                }
            } else {
                if left != nil, right != nil {
                    break
                }
            }
        }

        guard let leftIndex = left, let rightIndex = right else {
            return nil
        }

        return leftIndex ..< (rightIndex + 1) as? Self.Indices
    }
}
