//
//  AscArrayMutationTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import Foundation

import XCTest

import OrderedCollection

final class AscArrayMutationTest: XCTestCase {
    func testAppend() {
        var emptyArray = AscArray<Int>()

        emptyArray.reserveCapacity(100)
        XCTAssertEqual(emptyArray.capacity, 100)

        try? emptyArray.append(element: 2)
        try? emptyArray.append(element: 3)
        XCTAssertThrowsError(try emptyArray.append(element: 2))
        XCTAssert(Array(emptyArray) == [2, 3])

        var ascArray = try! AscArray([0, 1, 2, 3, 4])
        try? ascArray.append(element: 5)
        try? ascArray.append(element: 6)
        try? ascArray.append(element: 7)

        XCTAssert(Array(ascArray) == [0, 1, 2, 3, 4, 5, 6, 7])

        XCTAssertThrowsError(try ascArray.append(element: 6))
    }

    func testAppendCollection() {
        var emptyArray = AscArray<Int>()

        try? emptyArray.append(contentsOf: [0, 1, 2])

        XCTAssertEqual(Array(emptyArray), [0, 1, 2])

        try? emptyArray.append(contentsOf: [3, 4, 5])
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5])

        try? emptyArray.append(contentsOf: AscArray([6, 7, 8]))
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssertThrowsError(try emptyArray.append(contentsOf: [2, 3]))
        XCTAssertThrowsError(try emptyArray.append(contentsOf: AscArray([6, 7, 8])))

        try? emptyArray.append(contentsOf: [9, 10])
        XCTAssertEqual(Array(emptyArray), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

        emptyArray = AscArray<Int>()
        try? emptyArray.append(contentsOf: AscArray([0, 1, 2]))
        XCTAssertEqual(Array(emptyArray), [0, 1, 2])
    }

    func testInsertCollection() {
        var array = try! AscArray([0, 1, 2, 6, 7, 8])

        try? array.insert(3, at: 3)

        var test = [0, 1, 2, 6, 7, 8]
        test.insert(3, at: 3)
        XCTAssertEqual(test, test.sorted())
        XCTAssertEqual(test, Array(array))

        array = try! AscArray([0, 1, 2])
        try? array.insert(3, at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3])

        array = try! AscArray([3])
        try? array.insert(2, at: 0)
        XCTAssertEqual(Array(array), [2, 3])

        array = try! AscArray([1, 2, 3])
        try? array.insert(0, at: 0)
        XCTAssertEqual(Array(array), [0, 1, 2, 3])

        array = try! AscArray([0, 1, 2, 6, 7, 8])
        XCTAssertThrowsError(try array.insert(3, at: 2))
        XCTAssertThrowsError(try array.insert(9, at: 2))

        array = try! AscArray([0, 1, 2, 3])
        XCTAssertThrowsError(try array.insert(1, at: 0))

        array = try! AscArray([0, 1, 2, 3])
        XCTAssertThrowsError(try array.insert(2, at: 4))

        array = try! AscArray([0])
        XCTAssertThrowsError(try array.insert(1, at: 0))

        array = try! AscArray([3])
        XCTAssertThrowsError(try array.insert(2, at: 1))

        array = try! AscArray([0, 1, 2, 6, 7, 8])
        let insert = [3, 4, 5]

        try? array.insert(contentsOf: insert, at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([3, 4, 5, 6, 7, 8])
        try? array.insert(contentsOf: [0, 1, 2], at: 0)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        try? array.insert(contentsOf: [6, 7, 8], at: 6)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        try? array.insert(contentsOf: try! AscArray([6, 7, 8]), at: 6)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 6, 7, 8])

        array = try! AscArray([0, 1, 2, 5])
        try? array.insert(contentsOf: try! AscArray([3, 4, 5]), at: 3)
        XCTAssertEqual(Array(array), [0, 1, 2, 3, 4, 5, 5])

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [-1, 0, 1], at: 0))

        array = try! AscArray([0, 1, 2, 3, 4, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [4, 5, 6], at: 6))

        array = try! AscArray([0, 1, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [2, 3, 4, 5, 6], at: 2))

        array = try! AscArray([0, 1, 5])
        XCTAssertThrowsError(try array.insert(contentsOf: [0, 1], at: 2))
    }

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
        XCTAssertEqual(Array(array), [5, 6, 7, 8])
    }
}
