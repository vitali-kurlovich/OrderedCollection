//
//  AscArrayMutationTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class AscArrayMutationTest: XCTestCase {
    func testInsertCollection() {
        var array = try! AscArray([0, 1, 2, 6, 7, 8])

        try? array.insert(3, at: 3)

        var test = [0, 1, 2, 6, 7, 8]
        test.insert(3, at: 3)
        XCTAssertEqual(test, test.sorted())
        XCTAssertEqual(test, Array(array))

        array = try! AscArray([0, 1, 2])
        try? array.insert(3, at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3])

        array = try! AscArray([3])
        try? array.insert(2, at: 0)
        XCTAssertEqual(Array(array), [2, 3])

        array = try! AscArray([1, 2, 3])
        try? array.insert(0, at: 0)
        XCTAssertEqual(Array(array), [0, 1, 2, 3])

        array = try! AscArray([0, 1, 2, 6, 7, 8])
        XCTAssertThrowsError(try array.insert(3, at: 2))
        XCTAssertThrowsError(try array.insert(9, at: 2))

        array = try! AscArray([0, 1, 2, 3])
        XCTAssertThrowsError(try array.insert(1, at: 0))

        array = try! AscArray([0, 1, 2, 3])
        XCTAssertThrowsError(try array.insert(2, at: 4))

        array = try! AscArray([0])
        XCTAssertThrowsError(try array.insert(1, at: 0))

        array = try! AscArray([3])
        XCTAssertThrowsError(try array.insert(2, at: 1))

        array = try! AscArray([0, 1, 2, 6, 7, 8])
        let insert = [3, 4, 5]

        try? array.insert(contentsOf: insert, at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([3, 4, 5, 6, 7, 8])
        try? array.insert(contentsOf: [0, 1, 2], at: 0)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        try? array.insert(contentsOf: [6, 7, 8], at: 6)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        try? array.insert(contentsOf: try! AscArray([6, 7, 8]), at: 6)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 5])
        try? array.insert(contentsOf: try! AscArray([3, 4, 5]), at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 5])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [-1, 0, 1], at: 0))

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [4, 5, 6], at: 6))

        array = try! AscArray([0, 1, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [2, 3, 4, 5, 6], at: 2))

        array = try! AscArray([0, 1, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [0, 1], at: 2))
    }
}
