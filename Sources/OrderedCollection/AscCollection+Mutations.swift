//
//  AscCollection+Mutations.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/14/19.
//

import Foundation

extension AscCollection where Buffer == [Element] {
    public
    mutating func append(element: Element) throws {
        guard let last = self.last else {
            buffer.append(element)
            return
        }

        guard last <= element else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(element)
    }

    public
    mutating func append<S>(contentsOf newElements: S) throws where Element == S.Element, S: Sequence {
        var iterator = newElements.makeIterator()

        guard let left = iterator.next() else {
            return
        }

        if let last = last {
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }

        _ = try checkAscCollection(newElements)

        buffer.append(contentsOf: newElements)
    }

    public
    mutating func append(contentsOf newElements: AscCollection) throws {
        guard newElements.count > 0 else { return }

        if count == 0 {
            buffer = newElements.buffer
            return
        }

        let first = newElements.first!
        guard last! <= first else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(contentsOf: newElements.buffer)
    }

    public
    mutating func insert(_ newElement: Element, at i: Int) throws {
        if count == 0 {
            buffer.insert(newElement, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard newElement <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(newElement, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(newElement, at: i)
            return
        }

        let left = self[index(before: i)]
        let right = self[i]

        guard left <= newElement, newElement <= right else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(newElement, at: i)
    }

    public
    mutating func insert<C>(contentsOf newElements: C, at i: Int) throws where C: Collection, Element == C.Element {
        guard let left = newElements.first, let right = try checkAscCollection(newElements) else {
            return
        }

        if count == 0 {
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements, at: i)
            return
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements, at: i)
    }

    public
    mutating func insert(contentsOf newElements: AscCollection, at i: Int) throws {
        guard let left = newElements.first, let right = newElements.last else {
            return
        }

        if count == 0 {
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        if i == startIndex {
            let first = self.first!
            guard right <= first else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        if i == endIndex {
            let last = self.last!
            guard last <= left else {
                throw OrderedCollectionError.IncorrectValueError
            }
            buffer.insert(contentsOf: newElements.buffer, at: i)
            return
        }

        let sleft = self[index(before: i)]
        let sright = self[i]

        guard sleft <= left, right <= sright else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.insert(contentsOf: newElements.buffer, at: i)
    }

    public
    mutating func remove(at index: Int) -> Element {
        return buffer.remove(at: index)
    }

    /// Removes and returns the last element of the collection.
    ///
    /// The collection must not be empty.
    ///
    /// Calling this method may invalidate all saved indices of this
    /// collection. Do not rely on a previously stored index value after
    /// altering a collection with any operation that can change its length.
    ///
    /// - Returns: The last element of the collection.
    ///
    /// - Complexity: O(1)
    public
    mutating func removeLast() -> Element {
        return buffer.removeLast()
    }

    /// Removes all elements from the array.
    ///
    /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
    ///   the array after removing its elements. The default value is
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    public
    mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        buffer.removeAll(keepingCapacity: keepCapacity)
    }
}
