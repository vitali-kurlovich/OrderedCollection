//
//  AscArrayTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import XCTest

import OrderedCollection

final class AscArrayTest: XCTestCase {
    func testEqualable() {
        let ascArray = try! AscArray([0, 1, 2, 3, 4])
        let ascArray2 = try! AscArray([0, 1, 2, 3, 4])

        XCTAssertEqual(ascArray, ascArray2)

        XCTAssertNotEqual(try! AscArray([0, 1, 2, 3, 4]), try! AscArray([0, 1, 2, 3, 4, 5]))
        XCTAssertNotEqual(try! AscArray([1, 2, 3, 4]), try! AscArray([0, 1, 2, 3, 4]))

        XCTAssert(Array(ascArray) == [0, 1, 2, 3, 4])

        XCTAssert([Int]() == Array(AscArray<Int>()))

        XCTAssertTrue((try! AscArray([0, 1, 2, 3, 4])).elementsEqual([0, 1, 2, 3, 4]))
        let slice = [0, 1, 2, 3, 4][0 ..< 3]

        XCTAssertTrue((try! AscArray([0, 1, 2])).elementsEqual(slice))

        let array = try! AscArray([0, 1, 2, 3, 4])
        let ascSlice = array[0 ..< 3]

        let half = try! AscArray([0, 1, 2])
        XCTAssertTrue(ascSlice.elementsEqual(half))
    }

    func testAppend() {
        var emptyArray = AscArray<Int>()
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
        XCTAssert(Array(emptyArray) == [0, 1, 2])

        try? emptyArray.append(contentsOf: [3, 4, 5])
        XCTAssert(Array(emptyArray) == [0, 1, 2, 3, 4, 5])

        try? emptyArray.append(contentsOf: AscArray([6, 7, 8]))
        XCTAssert(Array(emptyArray) == [0, 1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssertThrowsError(try emptyArray.append(contentsOf: [2, 3]))
        XCTAssertThrowsError(try emptyArray.append(contentsOf: AscArray([6, 7, 8])))

        try? emptyArray.append(contentsOf: [9, 10])
        XCTAssert(Array(emptyArray) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

        emptyArray = AscArray<Int>()
        try? emptyArray.append(contentsOf: AscArray([0, 1, 2]))
        XCTAssert(Array(emptyArray) == [0, 1, 2])
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
        _ = array.remove(at: 2)
        XCTAssert(Array(array) == [6, 7, 9, 10])

        _ = array.removeLast()
        XCTAssert(Array(array) == [6, 7, 9])
    }

    func testContains() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertTrue(array.contains(3))

        XCTAssertTrue(array.contains(4, range: 3 ..< 7))
        XCTAssertTrue(array.contains(4, range: 2 ..< 5))

        XCTAssertTrue(array.contains(4))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(6))
        XCTAssertTrue(array.contains(7))
        XCTAssertTrue(array.contains(8))

        XCTAssertFalse(array.contains(0))
        XCTAssertFalse(array.contains(9))

        XCTAssertFalse(array.contains(4, range: 4 ..< 7))

        XCTAssertTrue(array.contains(less: 2))
        XCTAssertTrue(array.contains(greater: 2))

        XCTAssertFalse(array.contains(less: 1))
        XCTAssertFalse(array.contains(greater: 8))
    }

    func testMinMax() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(array.min(), 1)
        XCTAssertEqual(array.max(), 8)

        let emptyArray = AscArray<Int>()
        XCTAssertNil(emptyArray.min())
        XCTAssertNil(emptyArray.max())
    }

    func testConstructor() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])

        let a = Array(array)
        XCTAssertEqual(a, [1, 2, 3, 4, 5, 6, 7, 8])
    }

    func testSlice() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        let slice = array[1 ..< 6]
        XCTAssertEqual(Array(slice), [2, 3, 4, 5, 6])
    }

    func testReverse() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        let rev = array.reversed()

        XCTAssertEqual(Array(rev), [8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssertEqual(rev.reversed(), array)

        let slice = array[0 ..< 4]
        let revSlice = slice.reversed()
        XCTAssertEqual(Array(revSlice), [4, 3, 2, 1])
        XCTAssertEqual(revSlice.reversed(), slice)
    }
}
