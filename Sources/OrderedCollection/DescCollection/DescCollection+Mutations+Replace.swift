//
//  DescCollection+Mutations+Replace.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/18/19.
//

import Foundation

extension DescCollection where Buffer: MutationCollectionReplace,
    Buffer: Equatable,
    Buffer.Index == Int {
    public
    mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) throws where C: Collection, R: RangeExpression, Element == C.Element, Index == R.Bound {
        guard canReplace(subrange, with: newElements) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.replaceSubrange(subrange, with: newElements)
    }

    public
    mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) throws where C: BidirectionalCollection, R: RangeExpression, Element == C.Element, Index == R.Bound {
        guard canReplace(subrange, with: newElements) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.replaceSubrange(subrange, with: newElements)
    }

    public
    mutating func replaceSubrange<R>(_ subrange: R, with newElements: DescCollection) throws where R: RangeExpression, Index == R.Bound {
        guard canReplace(subrange, with: newElements) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.replaceSubrange(subrange, with: newElements)
    }
}

extension DescCollection where Buffer: MutationCollectionReplace,
    Buffer: Equatable,
    Buffer.Index == Int {
    internal
    func canReplace<C, R>(_ subrange: R, with newElements: C) -> Bool where C: Collection, R: RangeExpression, Element == C.Element, Index == R.Bound {
        let range = subrange.relative(to: self)
        return canReplace(range, with: newElements)
    }

    internal
    func canReplace<C, R>(_ subrange: R, with newElements: C) -> Bool where C: BidirectionalCollection, R: RangeExpression, Element == C.Element, Index == R.Bound {
        let range = subrange.relative(to: self)
        return canReplace(range, with: newElements)
    }

    internal
    func canReplace<R>(_ subrange: R, with newElements: DescCollection) -> Bool where R: RangeExpression, Index == R.Bound {
        let range = subrange.relative(to: self)
        return canReplace(range, with: newElements)
    }

    internal
    func canReplace<C>(_ range: Range<Index>, with newElements: C) -> Bool where C: Collection, Element == C.Element {
        guard let first = newElements.first else {
            return true
        }

        if range.isEmpty {
            let i = range.lowerBound
            return canInsert(contentsOf: newElements, at: i)
        }

        let left = indices.first != range.first ? self[index(before: range.first!)] : nil
        let right = indices.last != range.last ? self[index(after: range.last!)] : nil

        if let le = left {
            guard le >= first else {
                return false
            }
        }

        if let r = right {
            var iterator = newElements.makeIterator()
            guard var last = iterator.next() else {
                return true
            }

            while let element = iterator.next() {
                guard last >= element else {
                    return false
                }
                last = element
            }

            return last >= r
        }

        return isDescOrdered(newElements)
    }

    internal
    func canReplace<C>(_ range: Range<Index>, with newElements: C) -> Bool where C: BidirectionalCollection, Element == C.Element {
        guard let first = newElements.first else {
            return true
        }

        if range.isEmpty {
            let i = range.lowerBound
            return canInsert(contentsOf: newElements, at: i)
        }

        let left = indices.first != range.first ? self[index(before: range.first!)] : nil
        let right = indices.last != range.last ? self[index(after: range.last!)] : nil

        if let l = left {
            guard l >= first else {
                return false
            }
        }

        if let r = right {
            guard newElements.last! >= r else {
                return false
            }
            return isDescOrdered(newElements)
        }

        return isDescOrdered(newElements)
    }

    internal
    func canReplace(_ range: Range<Index>, with newElements: DescCollection) -> Bool {
        guard let first = newElements.first else {
            return true
        }

        if range.isEmpty {
            let i = range.lowerBound
            return canInsert(contentsOf: newElements, at: i)
        }

        let left = indices.first != range.first ? self[index(before: range.first!)] : nil
        let right = indices.last != range.last ? self[index(after: range.last!)] : nil

        if let l = left {
            guard l >= first else {
                return false
            }
        }

        if let r = right {
            guard newElements.last! >= r else {
                return false
            }
            return true
        }

        return true
    }
}
