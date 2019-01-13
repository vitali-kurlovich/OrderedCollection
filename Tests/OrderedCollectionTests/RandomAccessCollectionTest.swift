//
//  RandomAccessCollectionTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import XCTest

import OrderedCollection

final class RandomAccessCollectionTest: XCTestCase {
    func testRangeEqual() {
        var test = [0, 1, 2, 3, 4, 4, 4, 5, 6, 7, 8]
        var range = test.range(equal: 4)!
        XCTAssertEqual(range, 4 ..< 7)
        XCTAssertEqual(test[range], [4, 4, 4])

        test = [5]
        XCTAssertNil(test.range(equal: 4))
        range = test.range(equal: 5)!
        XCTAssertEqual(range, 0 ..< 1)
        XCTAssertEqual(test[range], [5])

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8]

        range = test.range(equal: 8)!
        XCTAssertEqual(range, 8 ..< 9)
        XCTAssertEqual(test[range], [8])

        range = test.range(equal: 0)!
        XCTAssertEqual(range, 0 ..< 1)
        XCTAssertEqual(test[range], [0])

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8]

        range = test.range(equal: 8)!
        XCTAssertEqual(range, 8 ..< 12)
        XCTAssertEqual(test[range], [8, 8, 8, 8])
    }

    func testRangeLess() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        var range = test.range(less: 5)!
        XCTAssertEqual(range, 0 ..< 5)
        XCTAssertEqual(test[range], [0, 1, 2, 3, 4])

        test = [4]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 0 ..< 1)
        XCTAssertEqual(test[range], [4])

        test = [4, 5]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 0 ..< 1)
        XCTAssertEqual(test[range], [4])

        test = [4, 4]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 0 ..< 2)
        XCTAssertEqual(test[range], [4, 4])

        test = [5]
        XCTAssertNil(test.range(less: 5))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertNil(test.range(less: 5, range: 5 ..< 9))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 4 ..< 9)
        XCTAssertEqual(test[range], [4, 3, 2, 1, 0])

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 0 ..< 5)
        XCTAssertEqual(test[range], [0, 1, 2, 3, 4])

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        range = test.range(less: 5, range: 5 ..< 18)!
        XCTAssertEqual(range, 9 ..< 14)
        XCTAssertEqual(test[range], [0, 1, 2, 3, 4])

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        range = test.range(less: 5)!
        XCTAssertEqual(range, 4 ..< 9)
        XCTAssertEqual(test[range], [4, 3, 2, 1, 0])

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        range = test.range(less: 5, range: 9 ..< 26)!

        XCTAssertEqual(range, 13 ..< 22)
        XCTAssertEqual(test[range], [4, 3, 2, 1, 0, 1, 2, 3, 4])
    }

    func testRangeLarge() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        var range = test.range(large: 5)!
        XCTAssertEqual(range, 6 ..< 9)
        XCTAssertEqual(test[range], [6, 7, 8])

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        range = test.range(large: 5)!
        XCTAssertEqual(range, 0 ..< 3)
        XCTAssertEqual(test[range], [8, 7, 6])

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        range = test.range(large: 5)!
        XCTAssertEqual(range, 6 ..< 9)
        XCTAssertEqual(test[range], [6, 7, 8])

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        range = test.range(large: 5)!
        XCTAssertEqual(range, 0 ..< 3)
        XCTAssertEqual(test[range], [8, 7, 6])

        test = [4]
        XCTAssertNil(test.range(large: 5))

        test = [5, 6]
        range = test.range(large: 5)!
        XCTAssertEqual(range, 1 ..< 2)
        XCTAssertEqual(test[range], [6])

        test = [6, 6]
        range = test.range(large: 5)!
        XCTAssertEqual(range, 0 ..< 2)
        XCTAssertEqual(test[range], [6, 6])
    }
}
