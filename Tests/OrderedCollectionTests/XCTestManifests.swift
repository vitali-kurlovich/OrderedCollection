import XCTest

extension AscArrayMutationAppendTest {
    static let __allTests = [
        ("testAppend", testAppend),
        ("testAppendCollection", testAppendCollection),
    ]
}

extension AscArrayMutationInsertTest {
    static let __allTests = [
        ("testInsertCollection", testInsertCollection),
        ("testInsertElement", testInsertElement),
    ]
}

extension AscArrayMutationRemoveTest {
    static let __allTests = [
        ("testRemove", testRemove),
    ]
}

extension AscArrayMutationReplaceTest {
    static let __allTests = [
        ("testCanReplace", testCanReplace),
        ("testReplace", testReplace),
    ]
}

extension AscArrayOpTest {
    static let __allTests = [
        ("testPlus", testPlus),
    ]
}

extension AscArrayTest {
    static let __allTests = [
        ("testConstructor", testConstructor),
        ("testContains", testContains),
        ("testEqualable", testEqualable),
        ("testMinMax", testMinMax),
        ("testReverse", testReverse),
        ("testSlice", testSlice),
        ("testSorted", testSorted),
        ("testUnsafeBufferPointer", testUnsafeBufferPointer),
        ("testUnsafeBytes", testUnsafeBytes),
    ]
}

extension DescArrayMutationAppendTest {
    static let __allTests = [
        ("testAppend", testAppend),
        ("testAppendCollection", testAppendCollection),
    ]
}

extension DescArrayMutationInsertTest {
    static let __allTests = [
        ("testInsertCollection", testInsertCollection),
        ("testInsertElement", testInsertElement),
    ]
}

extension DescArrayMutationRemoveTest {
    static let __allTests = [
        ("testRemove", testRemove),
    ]
}

extension DescArrayMutationReplaceTest {
    static let __allTests = [
        ("testCanReplace", testCanReplace),
        ("testReplace", testReplace),
    ]
}

extension DescArrayOpTest {
    static let __allTests = [
        ("testPlus", testPlus),
    ]
}

extension DescArrayTest {
    static let __allTests = [
        ("testConstructor", testConstructor),
        ("testContains", testContains),
        ("testEqualable", testEqualable),
        ("testMinMax", testMinMax),
        ("testReverse", testReverse),
        ("testSlice", testSlice),
        ("testSorted", testSorted),
        ("testUnsafeBufferPointer", testUnsafeBufferPointer),
        ("testUnsafeBytes", testUnsafeBytes),
    ]
}

extension OrderedCollectionPerformanceTests {
    static let __allTests = [
        ("testCondCount", testCondCount),
    ]
}

extension OrderedCollectionTests {
    static let __allTests = [
        ("testAllocationOrderedArray", testAllocationOrderedArray),
        ("testAscRangeLarge", testAscRangeLarge),
        ("testAscRangeLess", testAscRangeLess),
        ("testDescRangeLarge", testDescRangeLarge),
        ("testDescRangeLess", testDescRangeLess),
        ("testRangeEqual", testRangeEqual),
        ("testRangeEqualAsc", testRangeEqualAsc),
        ("testRangeEqualDesc", testRangeEqualDesc),
        ("testRangeLarge", testRangeLarge),
        ("testRangeLess", testRangeLess),
    ]
}

extension RandomAccessCollectionTest {
    static let __allTests = [
        ("testMinMax", testMinMax),
        ("testRangeEqual", testRangeEqual),
        ("testRangeLarge", testRangeLarge),
        ("testRangeLess", testRangeLess),
    ]
}

#if !os(macOS)
    public func __allTests() -> [XCTestCaseEntry] {
        return [
            testCase(AscArrayMutationAppendTest.__allTests),
            testCase(AscArrayMutationInsertTest.__allTests),
            testCase(AscArrayMutationRemoveTest.__allTests),
            testCase(AscArrayMutationReplaceTest.__allTests),
            testCase(AscArrayOpTest.__allTests),
            testCase(AscArrayTest.__allTests),
            testCase(DescArrayMutationAppendTest.__allTests),
            testCase(DescArrayMutationInsertTest.__allTests),
            testCase(DescArrayMutationRemoveTest.__allTests),
            testCase(DescArrayMutationReplaceTest.__allTests),
            testCase(DescArrayOpTest.__allTests),
            testCase(DescArrayTest.__allTests),
            testCase(OrderedCollectionPerformanceTests.__allTests),
            testCase(OrderedCollectionTests.__allTests),
            testCase(RandomAccessCollectionTest.__allTests),
        ]
    }
#endif
