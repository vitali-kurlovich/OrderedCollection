//
//  DescArrayTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/15/19.
//

import XCTest

import OrderedCollection

final class DescArrayTest: XCTestCase {
    func testEqualable() {
        let descArray = try! DescArray([4, 3, 2, 1, 0])
        let descArray2 = try! DescArray([4, 3, 2, 1, 0])

        XCTAssertEqual(descArray, descArray2)

        XCTAssertNotEqual(try! DescArray([4, 3, 2, 1, 0]), try! DescArray([5, 4, 3, 2, 1, 0]))
        XCTAssertNotEqual(try! DescArray([4, 3, 2, 1]), try! DescArray([4, 3, 2, 1, 0]))

        XCTAssert(Array(descArray) == [4, 3, 2, 1, 0])

        XCTAssert([Int]() == Array(DescArray<Int>()))

        XCTAssertTrue((try! DescArray([4, 3, 2, 1, 0])).elementsEqual([4, 3, 2, 1, 0]))
        let slice = [4, 3, 2, 1, 0][0 ..< 3]

        XCTAssertTrue((try! DescArray([4, 3, 2])).elementsEqual(slice))

        let array = try! DescArray([4, 3, 2, 1, 0])
        let ascSlice = array[0 ..< 3]

        let half = try! DescArray([4, 3, 2])
        XCTAssertTrue(ascSlice.elementsEqual(half))
    }

    func testContains() {
        var array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])

        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertTrue(array.contains(3))

        XCTAssertTrue(array.contains(4, range: 4 ..< 8))
        XCTAssertTrue(array.contains(4, range: 2 ..< 5))

        XCTAssertTrue(array.contains(4))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(6))
        XCTAssertTrue(array.contains(7))
        XCTAssertTrue(array.contains(8))

        XCTAssertFalse(array.contains(0))
        XCTAssertFalse(array.contains(9))

        XCTAssertFalse(array.contains(4, range: 1 ..< 4))
        XCTAssertFalse(array.contains(4, range: 5 ..< 7))

        XCTAssertTrue(array.contains(less: 2))
        XCTAssertTrue(array.contains(greater: 2))

        XCTAssertFalse(array.contains(less: 1))
        XCTAssertFalse(array.contains(greater: 8))

        array = try! DescArray([8, 7, 6, 5, 5, 5, 4, 3, 2, 1])

        XCTAssertEqual(array.firstIndex(of: 5), 3)
        XCTAssertNil(array.firstIndex(of: 9))

        XCTAssertEqual(array.lastIndex(of: 5), 5)
        XCTAssertNil(array.lastIndex(of: 9))

        XCTAssert(array.dropFirst() == [7, 6, 5, 5, 5, 4, 3, 2, 1])
        XCTAssert(array.dropLast() == [8, 7, 6, 5, 5, 5, 4, 3, 2])

        XCTAssert(array.dropFirst().dropFirst() == [6, 5, 5, 5, 4, 3, 2, 1])
        XCTAssert(array.dropLast().dropLast() == [8, 7, 6, 5, 5, 5, 4, 3])
    }

    func testMinMax() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssertEqual(array.min(), 1)
        XCTAssertEqual(array.max(), 8)

        let minmax = array.minmax()!
        XCTAssertEqual(minmax.min, 1)
        XCTAssertEqual(minmax.max, 8)

        let emptyArray = DescArray<Int>()
        XCTAssertNil(emptyArray.min())
        XCTAssertNil(emptyArray.max())
        XCTAssertNil(emptyArray.minmax())
    }

    func testConstructor() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])

        let a = Array(array)
        XCTAssertEqual(a, [8, 7, 6, 5, 4, 3, 2, 1])
    }

    func testSlice() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        let slice = array[1 ..< 6]
        XCTAssert(slice == [7, 6, 5, 4, 3])

        XCTAssert(slice[2...] == [6, 5, 4, 3])
    }

    func testReverse() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        let rev = array.reversed()

        XCTAssertEqual(Array(rev), [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(rev.reversed(), array)

        let slice = array[0 ..< 4]
        let revSlice = slice.reversed()
        XCTAssertEqual(Array(revSlice), [5, 6, 7, 8])
        XCTAssertEqual(revSlice.reversed(), slice)
    }

    func testSorted() {
        let array = try! DescArray([8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssert(array.sorted() == [1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssert(array[1 ... 4].sorted() == [4, 5, 6, 7])
    }

    func testUnsafeBufferPointer() {
        let numbers = try! DescArray([5, 4, 3, 2, 1])
        let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
            var result = 0
            for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
                result += buffer[i]
            }
            return result
        }

        XCTAssertEqual(sum, 9)
    }

    func testUnsafeBytes() {
        let numbers = try! DescArray([Int16(3), Int16(2), Int16(1)])
        var byteBuffer: [UInt8] = []
        numbers.withUnsafeBytes {
            byteBuffer.append(contentsOf: $0)
        }

        XCTAssert(byteBuffer == [3, 0, 2, 0, 1, 0])
    }
}
