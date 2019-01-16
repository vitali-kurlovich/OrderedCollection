//
//  DescArrayMutationInsertTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/17/19.
//

import XCTest

import OrderedCollection
//
final class DescArrayMutationInsertTest: XCTestCase {
    func testInsertElement() {
        var emptyArray = DescArray<Int>()

        try? emptyArray.insert(1, at: 0)
        try? emptyArray.insert(2, at: 0)
        try? emptyArray.insert(8, at: emptyArray.startIndex)
        try? emptyArray.insert(0, at: emptyArray.endIndex)
        try? emptyArray.insert(7, at: 1)
        try? emptyArray.insert(3, at: 2)
        try? emptyArray.insert(4, at: 2)
        try? emptyArray.insert(6, at: 2)
        try? emptyArray.insert(5, at: 3)

        XCTAssertTrue(emptyArray == [8, 7, 6, 5, 4, 3, 2, 1, 0])
        try? emptyArray.insert(7, at: 1)
        XCTAssertTrue(emptyArray == [8, 7, 7, 6, 5, 4, 3, 2, 1, 0])
        try? emptyArray.insert(8, at: 0)
        XCTAssertTrue(emptyArray == [8, 8, 7, 7, 6, 5, 4, 3, 2, 1, 0])
        try? emptyArray.insert(0, at: emptyArray.endIndex)
        XCTAssertTrue(emptyArray == [8, 8, 7, 7, 6, 5, 4, 3, 2, 1, 0, 0])

        var array = try! DescArray([7, 6, 5, 3, 1])
        try? array.insert(8, at: 0)
        try? array.insert(4, at: 4)
        try? array.insert(2, at: 6)
        try? array.insert(0, at: array.endIndex)
        try? array.insert(9, at: array.startIndex)

        XCTAssertTrue(array == [9, 8, 7, 6, 5, 4, 3, 2, 1, 0])

        array = try! DescArray([8, 7, 2, 1])
        XCTAssertThrowsError(try array.insert(7, at: 0))
        XCTAssertThrowsError(try array.insert(7, at: 0))
        XCTAssertThrowsError(try array.insert(2, at: array.endIndex))
        XCTAssertThrowsError(try array.insert(3, at: 3))
    }

    func testInsertCollection() {
        var array = try! DescArray([12, 8, 4, 0])
        XCTAssertThrowsError(try array.insert(contentsOf: [7, 6, 7], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [7, 6, 5, 4, 3], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [9, 8, 7, 6, 5], at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: [11], at: array.startIndex))
        XCTAssertThrowsError(try array.insert(contentsOf: [2], at: array.endIndex))

        try? array.insert(contentsOf: [7, 6, 5], at: 2)
        XCTAssertTrue(array == [12, 8, 7, 6, 5, 4, 0])

        array = try! DescArray([12, 8, 4, 0])
        try? array.insert(contentsOf: [8, 7, 6, 5, 4], at: 2)
        XCTAssertTrue(array == [12, 8, 8, 7, 6, 5, 4, 4, 0])

        array = try! DescArray([12, 8, 4, 0])

        XCTAssertThrowsError(try array.insert(contentsOf: try! DescArray([7, 6, 5, 4, 3]), at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: try! DescArray([9, 8, 7, 6, 5]), at: 2))
        XCTAssertThrowsError(try array.insert(contentsOf: try! DescArray([11]), at: array.startIndex))
        XCTAssertThrowsError(try array.insert(contentsOf: try! DescArray([2]), at: array.endIndex))

        try? array.insert(contentsOf: try! DescArray([7, 6, 5]), at: 2)
        XCTAssertTrue(array == [12, 8, 7, 6, 5, 4, 0])

        array = try! DescArray([12, 8, 4, 0])
        try? array.insert(contentsOf: try! DescArray([8, 7, 6, 5, 4]), at: 2)
        XCTAssertTrue(array == [12, 8, 8, 7, 6, 5, 4, 4, 0])
    }
}
