//
//  AscArrayOpTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

import XCTest

import OrderedCollection

final class AscArrayOpTest: XCTestCase {
    func testPlus() {
        var array = try! AscArray([0, 1, 2, 3, 4])

        XCTAssert((try! (array + AscArray([5, 6, 7]))) == [0, 1, 2, 3, 4, 5, 6, 7])

        XCTAssert((try! (array + [5, 6, 7])) == [0, 1, 2, 3, 4, 5, 6, 7])

        XCTAssert((try! (array + stride(from: 5, through: 10, by: 1))) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

        XCTAssert([5, 6, 7] + array == [5, 6, 7, 0, 1, 2, 3, 4])

        array = try! AscArray([0, 1, 2, 3, 4, 5, 6, 7])
        XCTAssertThrowsError(try array + [8, 9, 8])
        XCTAssertThrowsError(try array + [6, 7, 8])

        XCTAssertThrowsError(try array + AscArray([6, 7, 8]))
        XCTAssertThrowsError(try array + stride(from: 6, through: 8, by: 1))

        array = try! AscArray([Int]())
        XCTAssertThrowsError(try array + [8, 9, 8])

        array = try! AscArray([0, 1, 2, 3, 4])
        try? array += [5, 6, 7]
        XCTAssert(array == [0, 1, 2, 3, 4, 5, 6, 7])

        array = try! AscArray([0, 1, 2, 3, 4])
        try? array += stride(from: 5, through: 7, by: 1)
        XCTAssert(array == [0, 1, 2, 3, 4, 5, 6, 7])

        array = try! AscArray([0, 1, 2, 3, 4])
        try? array += try! AscArray([5, 6, 7])
        XCTAssert(array == [0, 1, 2, 3, 4, 5, 6, 7])
    }
}
