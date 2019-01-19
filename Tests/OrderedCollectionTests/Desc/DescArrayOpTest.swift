//
//  DescArrayOpTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/20/19.
//

import XCTest

import OrderedCollection

final class DescArrayOpTest: XCTestCase {
    func testPlus() {
        var array = try! DescArray([7, 6, 5])

        XCTAssert((try! (array + DescArray([4, 3, 2, 1, 0]))) == [7, 6, 5, 4, 3, 2, 1, 0])

        XCTAssert((try! (array + [4, 3, 2, 1, 0])) == [7, 6, 5, 4, 3, 2, 1, 0])

        array = try! DescArray([10, 9, 8, 7, 6])
        XCTAssert((try! (array + stride(from: 5, through: 0, by: -1))) == [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])

        XCTAssert([5, 6, 7] + array == [5, 6, 7, 10, 9, 8, 7, 6])

        array = try! DescArray([7, 6, 5, 4, 3])
        XCTAssertThrowsError(try array + [2, 1, 2])
        XCTAssertThrowsError(try array + [4, 3, 2])

        XCTAssertThrowsError(try array + DescArray([4, 3, 2]))
        XCTAssertThrowsError(try array + stride(from: 4, through: 2, by: -1))

        array = try! DescArray([Int]())
        XCTAssertThrowsError(try array + [9, 8, 9])

        array = try! DescArray([7, 6, 5, 4])
        try? array += [3, 2, 1, 0]
        XCTAssert(array == [7, 6, 5, 4, 3, 2, 1, 0])

        array = try! DescArray([7, 6, 5, 4])
        try? array += stride(from: 3, through: 0, by: -1)
        XCTAssert(array == [7, 6, 5, 4, 3, 2, 1, 0])

        array = try! DescArray([7, 6, 5, 4])
        try? array += try! DescArray([3, 2, 1, 0])
        XCTAssert(array == [7, 6, 5, 4, 3, 2, 1, 0])
    }
}
