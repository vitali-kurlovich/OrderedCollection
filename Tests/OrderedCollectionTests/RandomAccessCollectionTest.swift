//
//  RandomAccessCollectionTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import XCTest

final class RandomAccessCollectionTest: XCTestCase {
    func testRangeLess() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 0, upper: 4)))

        test = [4]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 0, upper: 0)))

        test = [4, 5]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 0, upper: 0)))

        test = [4, 4]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 0, upper: 1)))

        test = [5]
        XCTAssertNil(test.range(less: 5))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertNil(test.range(less: 5, range: Range(uncheckedBounds: (lower: 5, upper: 8))))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 4, upper: 8)))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 0, upper: 4)))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(less: 5, range: Range(uncheckedBounds: (lower: 5, upper: 17))), Range(uncheckedBounds: (lower: 9, upper: 13)))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        XCTAssertEqual(test.range(less: 5), Range(uncheckedBounds: (lower: 4, upper: 8)))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(less: 5, range: Range(uncheckedBounds: (lower: 9, upper: 25))), Range(uncheckedBounds: (lower: 13, upper: 21)))
    }

    func testRangeLarge() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(large: 5), Range(uncheckedBounds: (lower: 6, upper: 8)))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        XCTAssertEqual(test.range(large: 5), Range(uncheckedBounds: (lower: 0, upper: 2)))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(test.range(large: 5), Range(uncheckedBounds: (lower: 6, upper: 8)))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        XCTAssertEqual(test.range(large: 5), Range(uncheckedBounds: (lower: 0, upper: 2)))
    }
}
