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

        // let acsA = try! AscArray(testA)
        // let acsB = try! AscArray(testB)

        let descA = try! DescArray(testA.reversed())
        let descB = try! DescArray(testB.reversed())

        var test = [Int]()

        for i in 0 ..< 32 {
            test.append(i)
        }

        let desc = try! DescArray(test.reversed())

        resetStatistic()
        for val in 0 ..< test.count {
            _ = test.reversed().range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< desc.count {
            _ = desc.range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< testA.count {
            _ = testA.reversed().range(equal: val)
        }

        for val in 0 ..< testB.count {
            _ = testB.reversed().range(equal: val)
        }

        printStatistic()

        resetStatistic()
        for val in 0 ..< descA.count {
            _ = descA.range(equal: val)
        }

        for val in 0 ..< descB.count {
            _ = descB.range(equal: val)
        }

        printStatistic()

        return
            test.reserveCapacity(512 * 4)
        test.removeAll()
        test.append(Int.random(in: 0 ..< 5))
        test.append(test.last!)

        for _ in 0 ..< 40000 {
            let rnd = Int.random(in: 0 ..< 3)
            let last = test.last! + Int.random(in: 1 ..< 6)
            for _ in 0 ... rnd {
                test.append(last)
            }
        }

        let ascArray = try! AscArray(test)

        var empty = [Int]()
        for index in 1 ... 100 {
            let last = test.last! + index
            let first = test.first! - index
            empty.append(last)
            empty.append(first)
        }

        let values = Set(test).union(empty)

        print(ascArray.count)
        print(values.count)

        measure {
            for val in values {
                _ = ascArray.range(less: val)
            }
        }
    }
}
