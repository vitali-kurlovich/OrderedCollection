//
//  AscArrayMutationInsertTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/16/19.
//

import XCTest

import OrderedCollection
//
final class AscArrayMutationInsertTest: XCTestCase {
    func testInsertElement() {
        var emptyArray = AscArray<Int>()
        try? emptyArray.insert(3, at: 0)
        try? emptyArray.insert(1, at: 0)
        try? emptyArray.insert(2, at: 1)
        try? emptyArray.insert(4, at: 3)
        try? emptyArray.insert(5, at: emptyArray.endIndex)
        try? emptyArray.insert(0, at: emptyArray.startIndex)

        XCTAssertTrue(emptyArray == [0, 1, 2, 3, 4, 5])

        XCTAssertThrowsError(try emptyArray.insert(2, at: 1))
        XCTAssertThrowsError(try emptyArray.insert(4, at: emptyArray.endIndex))

        let array = try! AscArray([0, 2, 4, 6, 8, 10])
        var slice = array[2 ..< 5]
        try? slice.insert(3, at: 2)
        try? slice.insert(5, at: 4)

        XCTAssertTrue(slice == [3, 4, 5, 6, 8])
    }

    func testInsertCollection() {
        var array = try! AscArray([0, 4, 8, 12])
        XCTAssertThrowsError(try array.insert(contentsOf: [5, 6, 5], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [3, 4, 5], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [5, 6, 7, 8, 9], at: 2))

        try? array.insert(contentsOf: [5, 6, 7], at: 2)
        XCTAssertTrue(array == [0, 4, 5, 6, 7, 8, 12])

        try? array.insert(contentsOf: [1, 2, 3], at: 1)
        try? array.insert(contentsOf: [-1], at: array.startIndex)
        try? array.insert(contentsOf: [13, 14, 15], at: array.endIndex)

        XCTAssertTrue(array == [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15])

        array = try! AscArray([0, 1, 5, 6])
        try? array.insert(contentsOf: [1, 2, 3, 4], at: 2)
        XCTAssertTrue(array == [0, 1, 1, 2, 3, 4, 5, 6])

        array = try! AscArray([0, 1, 5, 6])
        try? array.insert(contentsOf: [2, 3, 4, 5], at: 2)
        XCTAssertTrue(array == [0, 1, 2, 3, 4, 5, 5, 6])

        array = try! AscArray([0, 1, 5, 6])
        XCTAssertThrowsError(try array.insert(contentsOf: [0, 1, 2, 3, 4, 5], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [2, 3, 4, 5, 6], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [1], at: 0))
        XCTAssertThrowsError(try array.insert(contentsOf: [0, 1], at: 0))
        XCTAssertThrowsError(try array.insert(contentsOf: [0, 1, 2], at: 1))
        XCTAssertThrowsError(try array.insert(contentsOf: [5, 6, 7], at: array.endIndex))

        // -----

        array = try! AscArray([0, 4, 8, 12])
        try? array.insert(contentsOf: try! AscArray([5, 6, 7]), at: 2)
        XCTAssertTrue(array == [0, 4, 5, 6, 7, 8, 12])

        try? array.insert(contentsOf: try! AscArray([1, 2, 3]), at: 1)
        try? array.insert(contentsOf: try! AscArray([-1]), at: array.startIndex)
        try? array.insert(contentsOf: try! AscArray([13, 14, 15]), at: array.endIndex)

        XCTAssertTrue(array == [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15])

        array = try! AscArray([0, 1, 5, 6])
        try? array.insert(contentsOf: try! AscArray([1, 2, 3, 4]), at: 2)
        XCTAssertTrue(array == [0, 1, 1, 2, 3, 4, 5, 6])

        array = try! AscArray([0, 1, 5, 6])
        try? array.insert(contentsOf: try! AscArray([2, 3, 4, 5]), at: 2)
        XCTAssertTrue(array == [0, 1, 2, 3, 4, 5, 5, 6])

        array = try! AscArray([0, 1, 5, 6])
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([0, 1, 2, 3, 4, 5]), at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([2, 3, 4, 5, 6]), at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([1]), at: 0))
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([0, 1]), at: 0))
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([0, 1, 2]), at: 1))
        XCTAssertThrowsError(try array.insert(contentsOf: try! AscArray([5, 6, 7]), at: array.endIndex))
    }
}
