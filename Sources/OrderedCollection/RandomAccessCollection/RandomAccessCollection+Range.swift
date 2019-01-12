//
//  RandomAccessCollection+Range.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

extension RandomAccessCollection where Self.Element: Equatable, Self.Index == Int {
    public
    func range(equal value: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        var l: Int?
        for index in range.lowerBound ... range.upperBound {
            if self[index] == value {
                l = index
                break
            }
        }

        guard let left = l else {
            return nil
        }

        var right = left
        for index in left ... range.upperBound {
            if self[index] == value {
                right = index
            } else {
                break
            }
        }

        return Range(uncheckedBounds: (lower: left, upper: right))
    }
}

extension RandomAccessCollection where Self.Element: Comparable, Self.Index == Int {
    public
    func range(less: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        var left: Int?
        var right: Int?

        for index in range.lowerBound ... range.upperBound {
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

        return Range(uncheckedBounds: (lower: leftIndex, upper: rightIndex))
    }

    public
    func range(large: Self.Element, range: Range<Int>? = nil) -> Range<Int>? {
        guard count > 0 else { return nil }

        let range = range != nil ? range! : Range(uncheckedBounds: (lower: 0, upper: count - 1))

        var left: Int?
        var right: Int?

        for index in range.lowerBound ... range.upperBound {
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

        return Range(uncheckedBounds: (lower: leftIndex, upper: rightIndex))
    }
}
