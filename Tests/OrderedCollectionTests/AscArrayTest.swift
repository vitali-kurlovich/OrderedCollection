//
//  AscArrayTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import XCTest

import OrderedCollection

final class AscArrayTest: XCTestCase {
    func testEqualable() {
        let ascArray = try! AscArray([0, 1, 2, 3, 4])
        let ascArray2 = try! AscArray([0, 1, 2, 3, 4])

        XCTAssertEqual(ascArray, ascArray2)

        XCTAssertNotEqual(try! AscArray([0, 1, 2, 3, 4]), try! AscArray([0, 1, 2, 3, 4, 5]))
        XCTAssertNotEqual(try! AscArray([1, 2, 3, 4]), try! AscArray([0, 1, 2, 3, 4]))

        XCTAssert(ascArray == [0, 1, 2, 3, 4])
        XCTAssert([0, 1, 2, 3, 4] == ascArray)

        XCTAssert([Int]() == AscArray<Int>())
    }

    func testAppend() {
        var emptyArray = AscArray<Int>()
        try? emptyArray.append(element: 2)
        try? emptyArray.append(element: 3)
        XCTAssertThrowsError(try emptyArray.append(element: 2))
        XCTAssert(emptyArray == [2, 3])

        var ascArray = try! AscArray([0, 1, 2, 3, 4])
        try? ascArray.append(element: 5)
        try? ascArray.append(element: 6)
        try? ascArray.append(element: 7)

        XCTAssert(ascArray == [0, 1, 2, 3, 4, 5, 6, 7])

        XCTAssertThrowsError(try ascArray.append(element: 6))
    }
}
