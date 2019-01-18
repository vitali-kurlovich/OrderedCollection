//
//  AscArrayMutationReplaceTest.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/17/19.
//

import XCTest

@testable import OrderedCollection

final class AscArrayMutationReplaceTest: XCTestCase {
    func testCanReplace() {
        let array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        XCTAssert(array.canReplace(0..., with: [0, 1, 2]))
        XCTAssert(array.canReplace(0 ... 1, with: [0, 1, 2]))
        XCTAssert(array.canReplace(0 ... 2, with: [0, 1, 2]))

        XCTAssertFalse(array.canReplace(0..., with: [0, 1, 0]))
        XCTAssertFalse(array.canReplace(0 ... 1, with: [0, 1, 0]))
        XCTAssertFalse(array.canReplace(0 ... 2, with: [0, 1, 0]))

        XCTAssertFalse(array.canReplace(1..., with: [0, 1, 2]))
        XCTAssertFalse(array.canReplace(1 ... 1, with: [0, 1, 2]))
        XCTAssertFalse(array.canReplace(1 ..< 2, with: [0, 1, 2]))

        XCTAssert(array.canReplace(0..., with: [8, 9, 10]))
        XCTAssert(array.canReplace(1..., with: [8, 9, 10]))
        XCTAssert(array.canReplace(...6, with: [8, 9, 10]))

        XCTAssert(array.canReplace(2 ..< 2, with: [2, 3]))
        XCTAssert(array.canReplace(0 ..< 0, with: [0, 1]))
        XCTAssert(array.canReplace(7 ..< 7, with: [8, 9]))
        XCTAssert(array.canReplace(7 ..< 7, with: [7, 8]))

        XCTAssertFalse(array.canReplace(...5, with: [8, 9, 10]))
        XCTAssertFalse(array.canReplace(..<6, with: [8, 9, 10]))
        XCTAssertFalse(array.canReplace(1 ..< 6, with: [8, 9, 10]))
        XCTAssertFalse(array.canReplace(2 ..< 6, with: [8, 9, 10]))
        XCTAssertFalse(array.canReplace(2 ..< 2, with: [8, 9, 10]))
        XCTAssertFalse(array.canReplace(0 ..< 0, with: [2, 3]))
        XCTAssertFalse(array.canReplace(7 ..< 7, with: [6, 7]))

        XCTAssert(array.canReplace(0..., with: try! AscArray([0, 1, 2])))
        XCTAssert(array.canReplace(0 ... 1, with: try! AscArray([0, 1, 2])))
        XCTAssert(array.canReplace(0 ... 2, with: try! AscArray([0, 1, 2])))

        XCTAssertFalse(array.canReplace(1..., with: try! AscArray([0, 1, 2])))
        XCTAssertFalse(array.canReplace(1 ... 1, with: try! AscArray([0, 1, 2])))
        XCTAssertFalse(array.canReplace(1 ..< 2, with: try! AscArray([0, 1, 2])))

        XCTAssert(array.canReplace(0..., with: try! AscArray([8, 9, 10])))
        XCTAssert(array.canReplace(1..., with: try! AscArray([8, 9, 10])))
        XCTAssert(array.canReplace(...6, with: try! AscArray([8, 9, 10])))

        XCTAssert(array.canReplace(2 ..< 2, with: try! AscArray([2, 3])))
        XCTAssert(array.canReplace(0 ..< 0, with: try! AscArray([0, 1])))
        XCTAssert(array.canReplace(7 ..< 7, with: try! AscArray([8, 9])))
        XCTAssert(array.canReplace(7 ..< 7, with: try! AscArray([7, 8])))

        XCTAssertFalse(array.canReplace(...5, with: try! AscArray([8, 9, 10])))
        XCTAssertFalse(array.canReplace(..<6, with: try! AscArray([8, 9, 10])))
        XCTAssertFalse(array.canReplace(1 ..< 6, with: try! AscArray([8, 9, 10])))
        XCTAssertFalse(array.canReplace(2 ..< 6, with: try! AscArray([8, 9, 10])))
        XCTAssertFalse(array.canReplace(2 ..< 2, with: try! AscArray([8, 9, 10])))
        XCTAssertFalse(array.canReplace(0 ..< 0, with: try! AscArray([2, 3])))
        XCTAssertFalse(array.canReplace(7 ..< 7, with: try! AscArray([6, 7])))
    }

    func testReplace() {
        var array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0 ... 1, with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2, 3, 4, 5, 6, 7])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0 ... 2, with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2, 4, 5, 6, 7])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0..., with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0 ... 3, with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2, 5, 6, 7])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0 ..< 3, with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2, 4, 5, 6, 7])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(0..., with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        try? array.replaceSubrange(...1, with: [0, 1, 2])
        XCTAssert(array == [0, 1, 2, 3, 4, 5, 6, 7])

        array = try! AscArray([1, 2, 12, 13])
        try? array.replaceSubrange(2 ..< 2, with: [3, 4, 5, 6, 7, 8, 9, 10, 11])
        XCTAssert(array == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])

        array = try! AscArray([1, 2, 12, 13])
        try? array.replaceSubrange(2 ..< 2, with: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
        XCTAssert(array == [1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 13])

        array = try! AscArray([1, 2, 12, 13])
        try? array.replaceSubrange(1 ... 2, with: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
        XCTAssert(array == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])

        array = try! AscArray([1, 2, 3, 4, 5, 6, 7])
        XCTAssertThrowsError(try array.replaceSubrange(1..., with: [0, 1, 2]))
    }
}
