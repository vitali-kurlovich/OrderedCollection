//
//  RandomAccessCollection+Range.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

extension BidirectionalCollection
    where Self.Element: Equatable,
    Self.Index.Stride == Self.Index, Self.Indices == Range<Self.Index> {
    public
    func range<R>(equal value: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        let r = range.relative(to: self)
        return self.range(equal: value, range: r)
    }

    public
    func range(equal value: Self.Element) -> Self.Indices? {
        return range(equal: value, range: indices)
    }

    private
    func range(equal value: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        guard count > 0 else { return nil }

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

        return (left ... right).relative(to: self)
    }
}

extension BidirectionalCollection
    where Self.Element: Comparable,
    Self.Index.Stride == Self.Index,
    Self.Indices == Range<Self.Index> {
    public
    func range<R>(less: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        let r = range.relative(to: self)
        return self.range(less: less, range: r)
    }

    public
    func range(less: Self.Element) -> Self.Indices? {
        return range(less: less, range: indices)
    }

    private
    func range(less: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        guard count > 0 else { return nil }

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

        return (leftIndex ... rightIndex).relative(to: self)
    }
}

extension BidirectionalCollection
    where Self.Element: Comparable,
    Self.Index.Stride == Self.Index,
    Self.Indices == Range<Self.Index> {
    public
    func range<R>(greater: Self.Element, in range: R) -> Self.Indices? where R: RangeExpression, Index == R.Bound {
        let r = range.relative(to: self)
        return self.range(greater: greater, range: r)
    }

    public
    func range(greater: Self.Element) -> Self.Indices? {
        return range(greater: greater, range: indices)
    }

    private
    func range(greater: Self.Element, range: Range<Self.Index>) -> Self.Indices? {
        guard count > 0 else { return nil }

        var left: Self.Index?
        var right: Self.Index?

        for index in range.first! ... range.last! {
            let value = self[index]
            if value > greater {
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

        return (leftIndex ... rightIndex).relative(to: self)
    }
}
