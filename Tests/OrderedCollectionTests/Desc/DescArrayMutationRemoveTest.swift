//
//  DescArrayMutationRemoveTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/16/19.
//

import XCTest

import OrderedCollection

final class DescArrayMutationRemoveTest: XCTestCase {
    func testRemove() {
        var array = try! DescArray([10, 9, 8, 7, 6])
        var result = array.remove(at: 2)
        XCTAssertEqual(result, 8)
        XCTAssert(array == [10, 9, 7, 6])

        result = array.removeLast()
        XCTAssertEqual(result, 6)
        XCTAssertEqual(Array(array), [10, 9, 7])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        var slice = array[2 ..< 5]
        XCTAssert(slice == [6, 5, 4])
        result = slice.remove(at: 2)
        XCTAssertEqual(result, 6)
        XCTAssert(slice == [5, 4])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        array.removeLast(3)
        XCTAssert(array == [8, 7, 6, 5, 4])
        array.removeAll()
        XCTAssert(array == [Int]())

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        array.removeSubrange(2 ..< 5)
        XCTAssert(array == [8, 7, 3, 2, 1])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        array.removeFirst(4)
        XCTAssertEqual(Array(array), [4, 3, 2, 1])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        result = array.removeFirst()
        XCTAssertEqual(result, 8)
        XCTAssertEqual(Array(array), [7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        array.removeSubrange(1 ... 3)
        XCTAssert(array == [8, 4, 3, 2, 1])

        array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        array.removeSubrange(...3)
        XCTAssert(array == [4, 3, 2, 1])
    }
}
