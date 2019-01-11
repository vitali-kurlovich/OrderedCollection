//
//  OrderedCollectionPerformanceTests.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/11/19.
//

import XCTest

import OrderedCollection

final class OrderedCollectionPerformanceTests: XCTestCase {
    func testCondCount() {
        var testA = [Int]()

        for _ in 0 ..< 100 {
            testA.append(testA.count)
        }

        var v = testA.count
        for _ in 0 ..< 4 {
            testA.append(v)
        }

        for _ in 0 ..< 100 {
            testA.append(testA.count - 4)
        }

        var testB = [Int]()

        for _ in 0 ..< 12 {
            testB.append(testB.count)
        }

        v = testB.count
        for _ in 0 ..< 44 {
            testB.append(v)
        }

        for _ in 0 ..< 1000 {
            testB.append(testB.count - 44)
        }

        let acsA = try! AscArray(testA)
        let acsB = try! AscArray(testB)

        var test = [Int]()

        for i in 0 ..< 50 {
            test.append(i)
        }

        let asc = try! AscArray(test)

        resetStatistic()
        for val in 0 ..< test.count {
            _ = test.range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< asc.count {
            _ = asc.range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< testA.count {
            _ = testA.range(equal: val)
        }

        for val in 0 ..< testB.count {
            _ = testB.range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< acsA.count {
            _ = acsA.range(equal: val)
        }

        for val in 0 ..< acsB.count {
            _ = acsB.range(equal: val)
        }

        printStatistic()
        /*
         measure {
         for val in 0..<acsA.count {
         _ = acsA.range(equal: val)
         }

         for val in 0..<acsB.count {
         _ = acsB.range(equal: val)
         }
         }
         */
    }
}
