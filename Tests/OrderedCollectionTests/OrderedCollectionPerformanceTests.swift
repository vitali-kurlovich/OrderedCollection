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

        test.reserveCapacity(25000 * 3 + 1)

        for i in 0 ... 25000 {
            for _ in 1 ... (i % 5 + 1) {
                test.append(i)
            }
        }

        var empty = [Int]()
        for index in 1 ... 100 {
            let last = test.last! + index
            let first = test.first! - index
            empty.append(last)
            empty.append(first)
        }

        let values = Set(test).union(empty)

        let ascArray = try! AscArray(test)
        print(test.count)
        print(values.count)

        measure {
            for val in values {
                // _ = ascArray.range(equal: val)
                _ = ascArray.contains(val)
            }
        }
    }
}
