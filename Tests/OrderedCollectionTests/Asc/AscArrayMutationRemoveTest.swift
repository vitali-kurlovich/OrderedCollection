//
//  AscArrayMutationRemoveTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class AscArrayMutationRemoveTest: XCTestCase {
    func testRemove() {
        var array = try! AscArray([6, 7, 8, 9, 10])
        var result = array.remove(at: 2)
        XCTAssertEqual(result, 8)
        XCTAssert(Array(array) == [6, 7, 9, 10])

        result = array.removeLast()
        XCTAssertEqual(result, 10)
        XCTAssertEqual(Array(array), [6, 7, 9])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        var slice = array[0 ..< 5]
        XCTAssertEqual(Array(slice), [1, 2, 3, 4, 5])
        result = slice.remove(at: 2)
        XCTAssertEqual(result, 3)
        XCTAssertEqual(Array(slice), [1, 2, 4, 5])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeLast(3)
        XCTAssertEqual(Array(array), [1, 2, 3, 4, 5])
        array.removeAll()
        XCTAssertEqual(Array(array), [Int]())

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeSubrange(2 ..< 5)
        XCTAssertEqual(Array(array), [1, 2, 6, 7, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeFirst(4)
        XCTAssertEqual(Array(array), [5, 6, 7, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        result = array.removeFirst()
        XCTAssertEqual(result, 1)
        XCTAssertEqual(Array(array), [2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeSubrange(1 ... 3)
        XCTAssertEqual(Array(array), [1, 5, 6, 7, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeSubrange(...3)
        XCTAssert(array == [5, 6, 7, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        array.removeAll { (element) -> Bool in
            element % 2 == 1
        }
        XCTAssert(array == [2, 4, 6, 8])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(array.popLast(), 8)
        XCTAssert(array == [1, 2, 3, 4, 5, 6, 7])
    }
}
