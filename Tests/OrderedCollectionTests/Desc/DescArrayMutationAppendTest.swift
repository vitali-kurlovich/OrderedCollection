//
//  DescArrayMutationAppendTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/16/19.
//

import XCTest

import OrderedCollection

final class DescArrayMutationAppendTest: XCTestCase {
    func testAppend() {
        var emptyArray = DescArray<Int>()

        emptyArray.reserveCapacity(100)
        XCTAssertEqual(emptyArray.capacity, 100)

        try? emptyArray.append(3)
        try? emptyArray.append(2)

        XCTAssertThrowsError(try emptyArray.append(3))
        XCTAssert(emptyArray == [3, 2])

        var descArray = try! DescArray([7, 6, 5, 4, 3])
        try? descArray.append(2)
        try? descArray.append(1)
        try? descArray.append(0)

        XCTAssert(descArray == [7, 6, 5, 4, 3, 2, 1, 0])
        XCTAssertThrowsError(try descArray.append(1))

        let array = try! DescArray([4, 3, 2, 1, 0])
        var slice = array[1 ..< 3]
        try? slice.append(1)
        XCTAssert(slice == [3, 2, 1])
    }

    func testAppendCollection() {
        var emptyArray = DescArray<Int>()

        try? emptyArray.append(contentsOf: [6, 5, 4])

        XCTAssert(emptyArray == [6, 5, 4])
        try? emptyArray.append(contentsOf: [])
        XCTAssert(emptyArray == [6, 5, 4])

        try? emptyArray.append(contentsOf: [4, 3])
        XCTAssert(emptyArray == [6, 5, 4, 4, 3])

        try? emptyArray.append(contentsOf: DescArray([3, 2, 1]))
        XCTAssert(emptyArray == [6, 5, 4, 4, 3, 3, 2, 1])

        XCTAssertThrowsError(try emptyArray.append(contentsOf: [2, 1]))
        XCTAssertThrowsError(try emptyArray.append(contentsOf: DescArray([6, 7, 8])))

        try? emptyArray.append(contentsOf: [1, 0])
        XCTAssert(emptyArray == [6, 5, 4, 4, 3, 3, 2, 1, 1, 0])

        emptyArray = DescArray<Int>()
        try? emptyArray.append(contentsOf: DescArray([2, 1, 0]))
        XCTAssert(emptyArray == [2, 1, 0])

        let array = try! DescArray([4, 3, 2, 1, 0])
        var slice = array[1 ..< 3]
        try? slice.append(contentsOf: [1, 0])
        XCTAssert(slice == [3, 2, 1, 0])
    }
}
