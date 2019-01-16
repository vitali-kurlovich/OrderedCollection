//
//  Mutation.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

public
protocol MutationCollectionCapacity {
    var capacity: Int { get }

    mutating
    func reserveCapacity(_ minimumCapacity: Int)
}

public
protocol MutationCollectionAppend {
    associatedtype Element

    /// Adds a new element at the end of the collection.
    ///
    /// - Parameter newElement: The element to append to the collection.
    mutating func append(_ newElement: Element)

    /// Adds the elements of a sequence to the end of the collection.
    ///
    /// - Parameter newElements: The elements to append to the collection.
    mutating func append<S>(contentsOf newElements: S) where Element == S.Element, S: Sequence
}

public
protocol MutationCollectionInsert {
    associatedtype Element

    /// Inserts a new element at the specified position.
    ///
    /// The new element is inserted before the element currently at the specified
    /// index. If you pass the array's `endIndex` property as the `index`
    /// parameter, the new element is appended to the collection.
    ///
    /// - Parameter newElement: The new element to insert into the array.
    /// - Parameter i: The position at which to insert the new element.
    ///   `index` must be a valid index of the collection or equal to its `endIndex`
    ///   property.
    mutating func insert(_ newElement: Element, at i: Int)

    /// Inserts the elements of a sequence into the collection at the specified
    /// position.
    ///
    /// The new elements are inserted before the element currently at the
    /// specified index. If you pass the collection's `endIndex` property as the
    /// `index` parameter, the new elements are appended to the collection.
    ///
    ///
    /// - Parameter newElements: The new elements to insert into the collection.
    /// - Parameter i: The position at which to insert the new elements. `index`
    ///   must be a valid index of the collection.
    ///
    /// - Complexity: O(*n* + *m*), where *n* is length of this collection and
    ///   *m* is the length of `newElements`. If `i == endIndex`, this method
    ///   is equivalent to `append(contentsOf:)`.
    mutating func insert<C>(contentsOf newElements: C, at i: Int) where C: Collection, Element == C.Element
}

public
protocol MutationCollectionRemove {
    associatedtype Element

    /// Removes and returns the element at the specified position.
    ///
    /// - Parameter index: The position of the element to remove. `index` must
    ///   be a valid index of the collection.
    /// - Returns: The element at the specified index.
    mutating
    func remove(at index: Int) -> Element

    /// Removes the elements in the specified subrange from the collection.
    ///
    /// - Parameter bounds: The range of the collection to be removed. The
    ///   bounds of the range must be valid indices of the collection.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating
    func removeSubrange(_ bounds: Range<Int>)

    /// Removes and returns the last element of the collection.
    ///
    /// - Returns: The last element of the collection.
    mutating
    func removeLast() -> Element

    /// Removes the specified number of elements from the beginning of the
    /// collection.
    ///
    /// - Parameter k: The number of elements to remove from the collection.
    ///   `k` must be greater than or equal to zero and must not exceed the
    ///   number of elements in the collection.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating
    func removeFirst(_ k: Int)

    /// Removes the given number of elements from the end of the collection.
    ///
    /// - Parameter k: The number of elements to remove. `k` must be greater
    ///   than or equal to zero, and must be less than or equal to the number of
    ///   elements in the collection.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the number of
    ///   elements to remove.
    mutating
    func removeLast(_ k: Int)

    /// Removes and returns the first element of the collection.
    ///
    /// The collection must not be empty.
    ///
    /// Calling this method may invalidate any existing indices for use with this
    /// collection.
    ///
    /// - Returns: The removed element.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating
    func removeFirst() -> Element

    /// Removes all elements from the collection.
    ///
    /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
    ///   the array after removing its elements. The default value is
    ///   `false`.
    mutating
    func removeAll(keepingCapacity keepCapacity: Bool)

    /// Removes the elements in the specified subrange from the collection.
    ///
    /// All the elements following the specified position are moved to close the
    /// gap. This example removes three elements from the middle of an array of
    /// measurements.
    ///
    /// - Parameter bounds: The range of the collection to be removed. The
    ///   bounds of the range must be valid indices of the collection.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func removeSubrange<R>(_ bounds: R) where R: RangeExpression, Array<Element>.Index == R.Bound
}

func foof() {
    var array = [0, 2]
    array.append(3)
}

extension Array: MutationCollectionCapacity {}
extension ArraySlice: MutationCollectionCapacity {}

extension Array: MutationCollectionAppend {}
extension ArraySlice: MutationCollectionAppend {}

extension Array: MutationCollectionRemove {}
extension ArraySlice: MutationCollectionRemove {}

extension Array: MutationCollectionInsert {}
extension ArraySlice: MutationCollectionInsert {}
