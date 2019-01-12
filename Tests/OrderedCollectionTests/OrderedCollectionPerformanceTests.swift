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
        

        var test = [Int]()

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
