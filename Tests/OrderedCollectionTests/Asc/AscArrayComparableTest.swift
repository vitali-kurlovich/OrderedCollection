//
//  AscArrayComparableTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class AscArrayComparableTest: XCTestCase {
    func testCompare() {
        let arrayEmptyA = try! AscArray([Int]())
        let arrayEmptyB = try! AscArray([Int]())

        let arrayA = try! AscArray([0, 1, 2, 3])
        let arrayB = try! AscArray([4, 5, 6, 7, 8])
        let arrayC = try! AscArray([9, 10, 11, 12])

        let arrayAQ = try! AscArray([0, 1, 2, 3, 4])
        let arrayCQ = try! AscArray([8, 9, 10, 11, 12])

        XCTAssertLessThan(arrayEmptyA, arrayA)
        XCTAssertLessThanOrEqual(arrayEmptyA, arrayEmptyB)
        XCTAssertLessThanOrEqual(arrayEmptyB, arrayEmptyA)
        XCTAssertGreaterThanOrEqual(arrayEmptyA, arrayEmptyB)
        XCTAssertGreaterThan(arrayA, arrayEmptyA)

        XCTAssertFalse(arrayEmptyA < arrayEmptyB)
        XCTAssertFalse(arrayEmptyA < arrayEmptyB)

        XCTAssertFalse(arrayA < arrayEmptyB)
        XCTAssertFalse(arrayA <= arrayEmptyB)
        XCTAssertFalse(arrayA == arrayEmptyB)

        XCTAssertLessThan(arrayA, arrayB)
        XCTAssertLessThan(arrayB, arrayC)
        XCTAssertLessThan(arrayA, arrayC)

        XCTAssertLessThanOrEqual(arrayA, arrayB)
        XCTAssertLessThanOrEqual(arrayB, arrayC)
        XCTAssertLessThanOrEqual(arrayA, arrayC)

        XCTAssertLessThanOrEqual(arrayAQ, arrayB)
        XCTAssertLessThanOrEqual(arrayB, arrayCQ)

        XCTAssertFalse(arrayA == arrayB)
        XCTAssertFalse(arrayA >= arrayB)

        XCTAssertFalse(arrayB == arrayC)
        XCTAssertFalse(arrayB >= arrayC)

        XCTAssertFalse(arrayA == arrayC)
        XCTAssertFalse(arrayA >= arrayC)

        XCTAssertFalse(arrayAQ < arrayB)
        XCTAssertFalse(arrayAQ == arrayB)
        XCTAssertFalse(arrayAQ > arrayB)

        XCTAssertFalse(arrayB < arrayCQ)
        XCTAssertFalse(arrayB == arrayCQ)
        XCTAssertFalse(arrayB > arrayCQ)

        XCTAssertGreaterThan(arrayB, arrayA)
        XCTAssertGreaterThan(arrayC, arrayB)
        XCTAssertGreaterThan(arrayC, arrayA)

        XCTAssertGreaterThanOrEqual(arrayB, arrayA)
        XCTAssertGreaterThanOrEqual(arrayC, arrayB)
        XCTAssertGreaterThanOrEqual(arrayC, arrayA)

        XCTAssertGreaterThanOrEqual(arrayB, arrayAQ)
        XCTAssertGreaterThanOrEqual(arrayCQ, arrayB)

        XCTAssertFalse(arrayB < arrayA)
        XCTAssertFalse(arrayB <= arrayA)
        XCTAssertFalse(arrayB == arrayA)
    }
}
