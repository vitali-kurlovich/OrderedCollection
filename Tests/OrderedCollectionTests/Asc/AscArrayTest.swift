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

        XCTAssertTrue(ascArray == [0, 1, 2, 3, 4])

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

    func testContains() {
        var array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(2))
        XCTAssertTrue(array.contains(3))

        XCTAssertTrue(array.contains(4, in: 3 ..< 7))
        XCTAssertTrue(array.contains(4, in: 2 ..< 5))

        XCTAssertTrue(array.contains(4))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(6))
        XCTAssertTrue(array.contains(7))
        XCTAssertTrue(array.contains(8))

        XCTAssertFalse(array.contains(0))
        XCTAssertFalse(array.contains(9))

        XCTAssertFalse(array.contains(4, in: 4 ..< 7))

        XCTAssertTrue(array.contains(less: 2))
        XCTAssertTrue(array.contains(greater: 2))

        XCTAssertFalse(array.contains(less: 1))
        XCTAssertFalse(array.contains(greater: 8))

        array = try! AscArray([1, 2, 3, 4, 5, 5, 5, 6, 7, 8])

        XCTAssertEqual(array.firstIndex(of: 5), 4)
        XCTAssertNil(array.firstIndex(of: 9))

        XCTAssertEqual(array.lastIndex(of: 5), 6)
        XCTAssertNil(array.lastIndex(of: 9))

        XCTAssert(array.dropFirst() == [2, 3, 4, 5, 5, 5, 6, 7, 8])
        XCTAssert(array.dropLast() == [1, 2, 3, 4, 5, 5, 5, 6, 7])

        XCTAssert(array.dropFirst().dropFirst() == [3, 4, 5, 5, 5, 6, 7, 8])
        XCTAssert(array.dropLast().dropLast() == [1, 2, 3, 4, 5, 5, 5, 6])
    }

    func testMinMax() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(array.min(), 1)
        XCTAssertEqual(array.max(), 8)

        let minmax = array.minmax()!
        XCTAssertEqual(minmax.min, 1)
        XCTAssertEqual(minmax.max, 8)

        let emptyArray = AscArray<Int>()
        XCTAssertNil(emptyArray.min())
        XCTAssertNil(emptyArray.max())
        XCTAssertNil(emptyArray.minmax())
    }

    func testConstructor() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])

        let a = Array(array)
        XCTAssertEqual(a, [1, 2, 3, 4, 5, 6, 7, 8])

        let ascArray = [3, 2, 1, 5, 4, 6, 8, 7].sorted()
        XCTAssertEqual(array, ascArray)
    }

    func testSlice() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])

        var test = [1, 2, 3, 4, 5, 6, 7, 8]
        var testSlice = test[1 ..< 6]
        XCTAssertEqual(testSlice, [2, 3, 4, 5, 6])
        testSlice = testSlice[2 ..< 4]
        XCTAssert(testSlice == [3, 4])

        let slice = array[1 ..< 6]
        XCTAssert(slice == [2, 3, 4, 5, 6])
        XCTAssert(slice[2 ..< 4] == [3, 4])
        XCTAssert(slice[2 ... 4] == [3, 4, 5])
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

    func testSorted() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssert(array.sorted() == [1, 2, 3, 4, 5, 6, 7, 8])

        XCTAssert(array[1 ... 4].sorted() == [2, 3, 4, 5])
    }

    func testUnsafeBufferPointer() {
        let numbers = try! AscArray([1, 2, 3, 4, 5])
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
        let numbers = try! AscArray([Int16(1), Int16(2), Int16(3)])
        var byteBuffer: [UInt8] = []
        numbers.withUnsafeBytes {
            byteBuffer.append(contentsOf: $0)
        }

        XCTAssert(byteBuffer == [1, 0, 2, 0, 3, 0])
    }

    func testCodable() {
        let enc = try! AscArray([1, 2, 3, 4])
        let data = try! JSONEncoder().encode(enc)
        let dec = try! JSONDecoder().decode(AscArray<Int>.self, from: data)
        XCTAssertEqual(enc, dec)
    }
}
