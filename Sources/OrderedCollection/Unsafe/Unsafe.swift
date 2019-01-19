//
//  Unsafe.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

public
protocol UnsafeCollectionPointer {
    associatedtype Element

    func withUnsafeBufferPointer<Result>(_ body: (UnsafeBufferPointer<Element>) throws -> Result) rethrows -> Result

    func withUnsafeBytes<Result>(_ body: (UnsafeRawBufferPointer) throws -> Result) rethrows -> Result
}

extension Array: UnsafeCollectionPointer {}
extension ArraySlice: UnsafeCollectionPointer {}
