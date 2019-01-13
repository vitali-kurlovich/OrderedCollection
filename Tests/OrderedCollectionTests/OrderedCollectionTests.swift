import class Foundation.Bundle
import XCTest

import OrderedCollection

final class OrderedCollectionTests: XCTestCase {
    func testAllocationOrderedArray() {
        XCTAssertThrowsError(
            try AscArray([2, 3, 4, 1])
        )

        XCTAssertThrowsError(
            try DescArray([5, 4, 3, 2, 1, 0, 2, 3, 4])
        )

        let emptyArray: [Int] = []
        XCTAssertNoThrow(try AscArray(emptyArray))
        XCTAssertNoThrow(try AscArray([1]))
        XCTAssertNoThrow(try AscArray([1, 2]))
        XCTAssertNoThrow(try AscArray([1, 1]))
        XCTAssertNoThrow(try AscArray([1, 1, 2, 2, 3]))

        XCTAssertNoThrow(try DescArray([Int]()))
        XCTAssertNoThrow(try DescArray([1]))
        XCTAssertNoThrow(try DescArray([2, 1]))
        XCTAssertNoThrow(try DescArray([1, 1]))
        XCTAssertNoThrow(try DescArray([3, 3, 2, 2, 1]))
    }

    func testRangeEqualAsc() {
        let test = [0, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 6, 7, 8, 8, 8, 8, 9, 9, 10, 11, 11, 11, 12, 12, 12, 12]

        let array = try! AscArray(test)

        let range = array.range(equal: 2)

        XCTAssertNotNil(range)
        XCTAssertEqual(range!, test.range(equal: 2))
    }

    func testRangeEqualDesc() {
        let test = [8, 7, 7, 7, 6, 6, 5, 4, 3, 3, 3, 2, 1, 0]
        let array = try! DescArray(test)
        // let range = Range(uncheckedBounds: (lower: 8, upper: 10))

        let range = array.range(equal: 3)

        XCTAssertNotNil(range)
        XCTAssertEqual(range!, test.range(equal: 3))
    }

    func testRangeEqual() {
        var test = [Int]()

        var asc = try! AscArray(test)
        var desc = try! DescArray(test)

        XCTAssertNil(asc.range(equal: 5))
        XCTAssertNil(desc.range(equal: 5))

        test = [3]
        asc = try! AscArray(test)
        desc = try! DescArray(test)

        XCTAssertNil(asc.range(equal: 5))
        XCTAssertNil(desc.range(equal: 5))

        test = [5]
        asc = try! AscArray(test)
        desc = try! DescArray(test)

        XCTAssertEqual(asc.range(equal: 5), test.range(equal: 5))
        XCTAssertEqual(desc.range(equal: 5), test.range(equal: 5))

        test = [5, 6]
        asc = try! AscArray(test)
        test = [6, 5]
        desc = try! DescArray(test)

        XCTAssertEqual(asc.range(equal: 5), [5, 6].range(equal: 5))
        XCTAssertEqual(desc.range(equal: 5), [6, 5].range(equal: 5))

        test = [5, 6, 7]
        asc = try! AscArray(test)
        test = [7, 6, 5]
        desc = try! DescArray(test)

        XCTAssertEqual(asc.range(equal: 5), [5, 6, 7].range(equal: 5))
        XCTAssertEqual(desc.range(equal: 5), [7, 6, 5].range(equal: 5))

        test = [3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(equal: 5))
        XCTAssertNil(desc.range(equal: 5))

        test = [2, 3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(equal: 5))
        XCTAssertNil(desc.range(equal: 5))

        test.reserveCapacity(18 * 3)
        for begin in 0 ..< 18 {
            for value in 0 ..< 18 {
                for end in 0 ..< 18 {
                    test.removeAll()

                    for _ in 0 ..< begin {
                        test.append(test.count)
                    }

                    let v = test.count
                    for _ in 0 ..< value {
                        test.append(v)
                    }

                    for _ in 0 ..< end {
                        test.append(test.count - value)
                    }

                    asc = try! AscArray(test)
                    desc = try! DescArray(test.reversed())

                    let values = Set(test)

                    for val in values {
                        let ascRange = test.range(equal: val)
                        let descRange = test.reversed().range(equal: val)

                        XCTAssertEqual(asc.range(equal: val), ascRange)
                        XCTAssertEqual(desc.range(equal: val), descRange)
                    }
                }
            }
        }
    }

    func testAscRangeLess() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]

        XCTAssertEqual(try! AscArray(test).range(less: 5), test.range(less: 5))

        test = [4]
        XCTAssertEqual(try! AscArray(test).range(less: 5), test.range(less: 5))

        test = [4, 5]
        XCTAssertEqual(try! AscArray(test).range(less: 5), test.range(less: 5))

        test = [4, 4]
        XCTAssertEqual(try! AscArray(test).range(less: 5), test.range(less: 5))

        test = [5]

        XCTAssertNil(try! AscArray(test).range(less: 5))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertNil(try! AscArray(test).range(less: 5, range: 5 ..< 9))
    }

    func testDescRangeLess() {
        var test = [8, 7, 6, 5, 4, 3, 2, 1, 0]

        XCTAssertEqual(try! DescArray(test).range(less: 5), test.range(less: 5))

        test = [4]
        XCTAssertEqual(try! DescArray(test).range(less: 5), test.range(less: 5))

        test = [5, 4]
        XCTAssertEqual(try! DescArray(test).range(less: 5), test.range(less: 5))

        test = [5]
        XCTAssertNil(try! DescArray(test).range(less: 5))

        test = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        XCTAssertNil(try! DescArray(test).range(less: 5, range: 0 ..< 4))

        test = [28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 15, 15, 15, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

        XCTAssertEqual(try! DescArray(test).range(less: 15), test.range(less: 15))
    }

    func testAscRangeLarge() {
        var test = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(try! AscArray(test).range(large: 5), test.range(large: 5))

        test = [4]
        XCTAssertEqual(try! AscArray(test).range(large: 2), test.range(large: 2))

        test = [5]
        XCTAssertNil(try! AscArray(test).range(large: 5))

        test = [5, 6]
        XCTAssertEqual(try! AscArray(test).range(large: 5), test.range(large: 5))

        test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 16, 16, 16, 16, 17, 18, 19]

        XCTAssertEqual(try! AscArray(test).range(large: 16), test.range(large: 16))
    }

    func testDescRangeLarge() {
        var test = [8, 7, 6, 5, 4, 3, 2, 1, 0]

        XCTAssertEqual(try! DescArray(test).range(large: 5), test.range(large: 5))

        test = [4]
        XCTAssertEqual(try! DescArray(test).range(large: 3), test.range(large: 3))

        test = [5]
        XCTAssertNil(try! DescArray(test).range(large: 5))

        test = [6, 5]
        XCTAssertEqual(try! DescArray(test).range(large: 5), test.range(large: 5))
    }

    func testRangeLess() {
        var test = [Int]()

        var asc = try! AscArray(test)
        var desc = try! DescArray(test)

        XCTAssertNil(asc.range(less: 5))
        XCTAssertNil(desc.range(less: 5))

        test = [3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(less: 3))
        XCTAssertNil(desc.range(less: 3))

        test = [2, 3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(less: 2))
        XCTAssertNil(desc.range(less: 2))

        test.reserveCapacity(18 * 3)
        for begin in 0 ..< 18 {
            for value in 0 ..< 18 {
                for end in 0 ..< 18 {
                    test.removeAll()

                    for _ in 0 ..< begin {
                        test.append(test.count)
                    }

                    let v = test.count
                    for _ in 0 ..< value {
                        test.append(v)
                    }

                    for _ in 0 ..< end {
                        test.append(test.count - value)
                    }

                    asc = try! AscArray(test)
                    desc = try! DescArray(test.reversed())

                    let values = Set(test)

                    for val in values {
                        let ascRange = test.range(less: val)
                        let descRange = test.reversed().range(less: val)

                        XCTAssertEqual(asc.range(less: val), ascRange)
                        XCTAssertEqual(desc.range(less: val), descRange)
                    }
                }
            }
        }
    }

    func testRangeLarge() {
        var test = [Int]()

        var asc = try! AscArray(test)
        var desc = try! DescArray(test)

        XCTAssertNil(asc.range(large: 5))
        XCTAssertNil(desc.range(large: 5))

        test = [3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(large: 4))
        XCTAssertNil(desc.range(large: 4))

        test = [2, 3, 4]
        asc = try! AscArray(test)
        desc = try! DescArray(test.reversed())

        XCTAssertNil(asc.range(large: 4))
        XCTAssertNil(desc.range(large: 4))

        test.reserveCapacity(18 * 3)
        for begin in 0 ..< 18 {
            for value in 0 ..< 18 {
                for end in 0 ..< 18 {
                    test.removeAll()

                    for _ in 0 ..< begin {
                        test.append(test.count)
                    }

                    let v = test.count
                    for _ in 0 ..< value {
                        test.append(v)
                    }

                    for _ in 0 ..< end {
                        test.append(test.count - value)
                    }

                    asc = try! AscArray(test)
                    desc = try! DescArray(test.reversed())

                    let values = Set(test)

                    for val in values {
                        let ascRange = test.range(large: val)
                        let descRange = test.reversed().range(large: val)

                        XCTAssertEqual(asc.range(large: val), ascRange)
                        XCTAssertEqual(desc.range(large: val), descRange)
                    }
                }
            }
        }
    }
}
