//
//  AscArrayMutationAppendTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class AscArrayMutationAppendTest: XCTestCase {
    func testAppend() {
        var emptyArray = AscArray<Int>()

        emptyArray.reserveCapacity(100)
        XCTAssertEqual(emptyArray.capacity, 100)

        try? emptyArray.append(2)
        try? emptyArray.append(3)
        XCTAssertThrowsError(try emptyArray.append(2))
        XCTAssertEqual(Array(emptyArray), [2, 3])

        var ascArray = try! AscArray([0, 1, 2, 3, 4])
        try? ascArray.append(5)
        try? ascArray.append(6)
        try? ascArray.append(7)

        XCTAssertEqual(Array(ascArray), [0, 1, 2, 3, 4, 5, 6, 7])

        XCTAssertThrowsError(try ascArray.append(6))

        let array = try! AscArray([0, 1, 2, 3, 4])
        var slice = array[0 ..< 3]
        try? slice.append(10)
        XCTAssert(slice == [0, 1, 2, 10])
    }

    func testAppendCollection() {
        var emptyArray = AscArray<Int>()

        try? emptyArray.append(contentsOf: [0, 1, 2])

        XCTAssert(emptyArray == [0, 1, 2])
        try? emptyArray.append(contentsOf: [])
        XCTAssert(emptyArray == [0, 1, 2])

        try? emptyArray.append(contentsOf: [3, 4, 5])
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5])

        try? emptyArray.append(contentsOf: AscArray([6, 7, 8]))
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssertThrowsError(try emptyArray.append(contentsOf: [2, 3]))
        XCTAssertThrowsError(try emptyArray.append(contentsOf: AscArray([6, 7, 8])))

        try? emptyArray.append(contentsOf: [9, 10])
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

        emptyArray = AscArray<Int>()
        try? emptyArray.append(contentsOf: AscArray([0, 1, 2]))
        XCTAssertEqual(Array(emptyArray), [0, 1, 2])

        let array = try! AscArray([0, 1, 2, 3, 4])
        var slice = array[0 ..< 3]
        try? slice.append(contentsOf: [10, 11, 12])
        XCTAssert(slice == [0, 1, 2, 10, 11, 12])
    }
}
