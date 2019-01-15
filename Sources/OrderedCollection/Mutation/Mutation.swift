//
//  Mutation.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

public
protocol MutationCollectionRemove {
    associatedtype Element
    
    mutating
    func remove(at index: Int) -> Element
    
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
    mutating
    func removeLast() -> Element
    
    /// Removes all elements from the array.
    ///
    /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
    ///   the array after removing its elements. The default value is
    ///   `false`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    mutating
    func removeAll(keepingCapacity keepCapacity: Bool)
}


extension Array : MutationCollectionRemove {
    
}

extension ArraySlice : MutationCollectionRemove {
    
}
