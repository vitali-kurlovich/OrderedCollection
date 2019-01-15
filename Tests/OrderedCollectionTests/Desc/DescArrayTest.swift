//
//  DescArrayTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class DescArrayTest: XCTestCase {
    func testEqualable() {
        let descArray = try! DescArray([4, 3, 2, 1, 0])
        let descArray2 = try! DescArray([4, 3, 2, 1, 0])

        XCTAssertEqual(descArray, descArray2)

        XCTAssertNotEqual(try! DescArray([4, 3, 2, 1, 0]), try! DescArray([5, 4, 3, 2, 1, 0]))
        XCTAssertNotEqual(try! DescArray([4, 3, 2, 1]), try! DescArray([4, 3, 2, 1, 0]))

        XCTAssert(Array(descArray) == [4, 3, 2, 1, 0])

        XCTAssert([Int]() == Array(DescArray<Int>()))

        XCTAssertTrue((try! DescArray([4, 3, 2, 1, 0])).elementsEqual([4, 3, 2, 1, 0]))
        let slice = [4, 3, 2, 1, 0][0 ..< 3]

        XCTAssertTrue((try! DescArray([4, 3, 2])).elementsEqual(slice))

        let array = try! DescArray([4, 3, 2, 1, 0])
        let ascSlice = array[0 ..< 3]

        let half = try! DescArray([4, 3, 2])
        XCTAssertTrue(ascSlice.elementsEqual(half))
    }

    func testContains() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])

        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertTrue(array.contains(3))

        XCTAssertTrue(array.contains(4, range: 4 ..< 8))
        XCTAssertTrue(array.contains(4, range: 2 ..< 5))

        XCTAssertTrue(array.contains(4))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(6))
        XCTAssertTrue(array.contains(7))
        XCTAssertTrue(array.contains(8))

        XCTAssertFalse(array.contains(0))
        XCTAssertFalse(array.contains(9))

        XCTAssertFalse(array.contains(4, range: 1 ..< 4))
        XCTAssertFalse(array.contains(4, range: 5 ..< 7))

        XCTAssertTrue(array.contains(less: 2))
        XCTAssertTrue(array.contains(greater: 2))

        XCTAssertFalse(array.contains(less: 1))
        XCTAssertFalse(array.contains(greater: 8))
    }

    func testMinMax() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssertEqual(array.min(), 1)
        XCTAssertEqual(array.max(), 8)

        let minmax = array.minmax()!
        XCTAssertEqual(minmax.min, 1)
        XCTAssertEqual(minmax.max, 8)

        let emptyArray = DescArray<Int>()
        XCTAssertNil(emptyArray.min())
        XCTAssertNil(emptyArray.max())
        XCTAssertNil(emptyArray.minmax())
    }

    func testConstructor() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])

        let a = Array(array)
        XCTAssertEqual(a, [8, 7, 6, 5, 4, 3, 2, 1])
    }

    func testSlice() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        let slice = array[1 ..< 6]
        XCTAssertEqual(Array(slice), [7, 6, 5, 4, 3])
    }

    func testReverse() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        let rev = array.reversed()

        XCTAssertEqual(Array(rev), [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(rev.reversed(), array)

        let slice = array[0 ..< 4]
        let revSlice = slice.reversed()
        XCTAssertEqual(Array(revSlice), [5, 6, 7, 8])
        XCTAssertEqual(revSlice.reversed(), slice)
    }
}