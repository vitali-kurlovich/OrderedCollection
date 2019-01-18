//
//  DescArrayMutationReplaceTest.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/18/19.
//

import XCTest

@testable import OrderedCollection

final class DescArrayMutationReplaceTest: XCTestCase {
    func testCanReplace() {
        let array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        XCTAssert(array.canReplace(0..., with: [8, 7, 6]))
        XCTAssert(array.canReplace(0 ... 1, with: [8, 7, 6]))
        XCTAssert(array.canReplace(0 ... 2, with: [8, 7, 6]))

        XCTAssertFalse(array.canReplace(0..., with: [8, 7, 8]))
        XCTAssertFalse(array.canReplace(0 ... 1, with: [8, 7, 8]))
        XCTAssertFalse(array.canReplace(0 ... 2, with: [8, 7, 8]))

        XCTAssertFalse(array.canReplace(1..., with: [8, 7, 6]))
        XCTAssertFalse(array.canReplace(1 ... 1, with: [8, 7, 6]))
        XCTAssertFalse(array.canReplace(1 ..< 2, with: [8, 7, 6]))

        XCTAssert(array.canReplace(0..., with: [0, -1, -2]))
        XCTAssert(array.canReplace(1..., with: [0, -1, -2]))
        XCTAssert(array.canReplace(...6, with: [0, -1, -2]))

        XCTAssert(array.canReplace(2 ..< 2, with: [6, 5]))
        XCTAssert(array.canReplace(0 ..< 0, with: [8, 7]))
        XCTAssert(array.canReplace(7 ..< 7, with: [0, -1]))
        XCTAssert(array.canReplace(7 ..< 7, with: [1, 0]))

        XCTAssertFalse(array.canReplace(...5, with: [2, 1, 0]))
        XCTAssertFalse(array.canReplace(..<6, with: [2, 1, 0]))
        XCTAssertFalse(array.canReplace(1 ..< 6, with: [2, 1, 0]))
        XCTAssertFalse(array.canReplace(2 ..< 6, with: [2, 1, 0]))
        XCTAssertFalse(array.canReplace(2 ..< 2, with: [2, 1, 0]))
        XCTAssertFalse(array.canReplace(0 ..< 0, with: [7, 6]))
        XCTAssertFalse(array.canReplace(7 ..< 7, with: [2, 1]))

        XCTAssert(array.canReplace(0..., with: try! DescArray([8, 7, 6])))
        XCTAssert(array.canReplace(0 ... 1, with: try! DescArray([8, 7, 6])))
        XCTAssert(array.canReplace(0 ... 2, with: try! DescArray([8, 7, 6])))

        XCTAssertFalse(array.canReplace(1..., with: try! DescArray([8, 7, 6])))
        XCTAssertFalse(array.canReplace(1 ... 1, with: try! DescArray([8, 7, 6])))
        XCTAssertFalse(array.canReplace(1 ..< 2, with: try! DescArray([8, 7, 6])))

        XCTAssert(array.canReplace(0..., with: try! DescArray([0, -1, -2])))
        XCTAssert(array.canReplace(1..., with: try! DescArray([0, -1, -2])))
        XCTAssert(array.canReplace(...6, with: try! DescArray([0, -1, -2])))

        XCTAssert(array.canReplace(2 ..< 2, with: try! DescArray([6, 5])))
        XCTAssert(array.canReplace(0 ..< 0, with: try! DescArray([8, 7])))
        XCTAssert(array.canReplace(7 ..< 7, with: try! DescArray([0, -1])))
        XCTAssert(array.canReplace(7 ..< 7, with: try! DescArray([1, 0])))

        XCTAssertFalse(array.canReplace(...5, with: try! DescArray([2, 1, 0])))
        XCTAssertFalse(array.canReplace(..<6, with: try! DescArray([2, 1, 0])))
        XCTAssertFalse(array.canReplace(1 ..< 6, with: try! DescArray([2, 1, 0])))
        XCTAssertFalse(array.canReplace(2 ..< 6, with: try! DescArray([2, 1, 0])))
        XCTAssertFalse(array.canReplace(2 ..< 2, with: try! DescArray([2, 1, 0])))
        XCTAssertFalse(array.canReplace(0 ..< 0, with: try! DescArray([7, 6])))
        XCTAssertFalse(array.canReplace(7 ..< 7, with: try! DescArray([2, 1])))
    }

    func testReplace() {
        var array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0 ... 1, with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0 ... 1, with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0 ... 2, with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6, 4, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0..., with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0 ... 3, with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0 ..< 3, with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6, 4, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(0..., with: [8, 7, 6])
        XCTAssert(array == [8, 7, 6])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        try? array.replaceSubrange(...1, with: try! DescArray([8, 7, 6]))
        XCTAssert(array == [8, 7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([13, 12, 2, 1])
        try? array.replaceSubrange(2 ..< 2, with: try! DescArray([11, 10, 9, 8, 7, 6, 5, 4, 3]))
        XCTAssert(array == [13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([13, 12, 2, 1])
        try? array.replaceSubrange(2 ..< 2, with: [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2])
        XCTAssert(array == [13, 12, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 2, 1])

        array = try! DescArray([13, 12, 2, 1])
        try? array.replaceSubrange(1 ... 2, with: try! DescArray([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2]))
        XCTAssert(array == [13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

        array = try! DescArray([7, 6, 5, 4, 3, 2, 1])
        XCTAssertThrowsError(try array.replaceSubrange(1..., with: [8, 7, 6]))
    }
}
