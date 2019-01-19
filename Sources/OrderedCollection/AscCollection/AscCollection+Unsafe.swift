//
//  AscCollection+Unsafe.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

extension AscCollection: UnsafeCollectionPointer where Buffer: UnsafeCollectionPointer {
    public func withUnsafeBufferPointer<Result>(_ body: (UnsafeBufferPointer<Element>) throws -> Result) rethrows -> Result {
        return try buffer.withUnsafeBufferPointer(body)
    }

    public func withUnsafeBytes<Result>(_ body: (UnsafeRawBufferPointer) throws -> Result) rethrows -> Result {
        return try buffer.withUnsafeBytes(body)
    }
}
