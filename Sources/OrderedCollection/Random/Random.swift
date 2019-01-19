//
//  Random.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

/*
 public
 protocol UnsafeCollectionPointer {
 associatedtype Element

 func withUnsafeBufferPointer<Result>(_ body: (UnsafeBufferPointer<Element>) throws -> Result) rethrows -> Result

 func withUnsafeBytes<Result>(_ body: (UnsafeRawBufferPointer) throws -> Result) rethrows -> Result
 }

 extension Array: UnsafeCollectionPointer {}
 extension ArraySlice: UnsafeCollectionPointer {}
 */

public
protocol RandomElementProtocol {
    associatedtype Element

    func randomElement<T>(using generator: inout T) -> Element? where T: RandomNumberGenerator
    func randomElement() -> Element?
}

extension Array: RandomElementProtocol {}
extension ArraySlice: RandomElementProtocol {}
