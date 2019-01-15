//
//  DescArrayComparableTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/16/19.
//

import Foundation

import XCTest

import OrderedCollection

final class DescArrayComparableTest: XCTestCase {
    func testCompare() {
        let arrayEmptyA = try! DescArray([Int]())
        let arrayEmptyB = try! DescArray([Int]())

        let arrayA = try! DescArray([12, 11, 10, 9])
        let arrayB = try! DescArray([8, 7, 6, 5, 4])
        let arrayC = try! DescArray([3, 2, 1, 0])

        let arrayAQ = try! DescArray([12, 11, 10, 9, 8])
        let arrayCQ = try! DescArray([4, 3, 2, 1, 0])

        // [12, 11, 10, 9, 8] >= [8, 7, 6, 5, 4 ]
        XCTAssertTrue(arrayAQ >= arrayB)
        // [8, 7, 6, 5, 4 ] >= [4, 3, 2, 1, 0]
        XCTAssertTrue(arrayB >= arrayCQ)

        XCTAssertFalse(arrayAQ > arrayB)
        XCTAssertFalse(arrayCQ > arrayB)

        XCTAssertFalse(arrayAQ == arrayB)
        XCTAssertFalse(arrayCQ == arrayB)

        XCTAssertFalse(arrayAQ < arrayB)
        XCTAssertFalse(arrayCQ > arrayB)

        // [12, 11, 10, 9, 8] <= [8, 7, 6, 5, 4 ]
        XCTAssertTrue(arrayAQ <= arrayB)
        // [8, 7, 6, 5, 4 ] < [12, 11, 10, 9, 8]
        XCTAssertTrue(arrayB < arrayAQ)

        // [4, 3, 2, 1, 0] < [8, 7, 6, 5, 4 ]
        XCTAssertTrue(arrayCQ < arrayB)
        // [4, 3, 2, 1, 0] <= [8, 7, 6, 5, 4 ]
        XCTAssertFalse(arrayCQ <= arrayB)

        XCTAssertTrue(arrayA > arrayB)
        XCTAssertTrue(arrayA >= arrayB)

        XCTAssertFalse(arrayA == arrayB)
        XCTAssertFalse(arrayA <= arrayB)
        XCTAssertFalse(arrayA < arrayB)

        XCTAssertTrue(arrayB > arrayC)
        XCTAssertTrue(arrayB >= arrayC)

        XCTAssertFalse(arrayB == arrayC)
        XCTAssertFalse(arrayB <= arrayC)
        XCTAssertFalse(arrayB < arrayC)
    }
}
