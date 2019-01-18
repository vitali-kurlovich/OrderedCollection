//
//  AscCollection+Mutations+Insert.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

extension AscCollection where Buffer: MutationCollectionInsert,
    Buffer: Equatable,
    Buffer.Index == Int {
    public
    mutating func insert(_ newElement: Element, at i: Int) throws {
        guard canInsert(newElement: newElement, at: i) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(newElement, at: i)
    }

    public
    mutating func insert<C>(contentsOf newElements: C, at i: Int) throws where C: Collection, Element == C.Element {
        guard canInsert(contentsOf: newElements, at: i) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements, at: i)
    }

    public
    mutating func insert(contentsOf newElements: AscCollection, at i: Int) throws {
        guard canInsert(contentsOf: newElements, at: i) else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements.buffer, at: i)
    }
}

extension AscCollection where Buffer: Equatable,
    Buffer.Index == Int {
    internal
    func canInsert(newElement: Element, at i: Int) -> Bool {
        guard let first = self.first else {
            return true
        }

        if i == startIndex {
            guard newElement <= first else {
                return false
            }
            return true
        }

        if i == endIndex {
            let last = self.last!
            guard last <= newElement else {
                return false
            }
            return true
        }

        let left = self[index(before: i)]
        let right = self[i]

        guard left <= newElement, newElement <= right else {
            return false
        }

        return true
    }

    internal
    func canInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C: BidirectionalCollection, Element == C.Element {
        guard let left = newElements.first, let right = newElements.last else {
            return true
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                return false
            }
            return isAscOrdered(newElements)
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                return false
            }
            return isAscOrdered(newElements)
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            return false
        }

        return isAscOrdered(newElements)
    }

    internal
    func canInsert<C>(contentsOf newElements: C, at i: Int) -> Bool where C: Sequence, Element == C.Element {
        var iterator = newElements.makeIterator()
        guard let left = iterator.next() else {
            return true
        }

        var right = left

        while let element = iterator.next() {
            guard right <= element else {
                return false
            }
            right = element
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                return false
            }
            return true
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                return false
            }
            return true
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            return false
        }

        return true
    }

    internal
    func canInsert(contentsOf newElements: AscCollection, at i: Int) -> Bool {
        guard let left = newElements.first, let right = newElements.last else {
            return true
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                return false
            }
            return true
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                return false
            }
            return true
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            return false
        }

        return true
    }
}
