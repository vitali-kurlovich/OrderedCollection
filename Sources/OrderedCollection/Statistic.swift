//
//  Statistic.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

private
var conditionalCounter = 0

public
func resetStatistic() {
    conditionalCounter = 0
}

public
func incConditional() {
    #if DEBUG
        conditionalCounter += 1
    #endif
}

public
func printStatistic() {
    print("Statistic:")
    print("Conditionals count:\(conditionalCounter)")
}
