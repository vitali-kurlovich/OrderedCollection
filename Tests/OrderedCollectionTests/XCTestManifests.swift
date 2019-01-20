//
//  XCTestManifests.swift
//  OrderedCollectionTests
//
//  Created by Vitali Kurlovich on 1/20/19.
//

import XCTest

#if !os(macOS)
    public func allTests() -> [XCTestCaseEntry] {
        return [
            testCase(OrderedCollectionTests.allTests),
        ]
    }
#endif
