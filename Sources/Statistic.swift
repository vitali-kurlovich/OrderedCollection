//
//  Statistic.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/10/19.
//

import Foundation

private
var callsCounter = 0

private
var conditionalCounter = 0

internal
func resetStatistic() {
    callsCounter = 0
    conditionalCounter = 0
}

internal
func incCalls() {
    #if DEBUG
        callsCounter += 1
    
    #endif
}

internal
func incConditional() {
     #if DEBUG
    conditionalCounter += 1
    #endif
}

internal
func printStatistic() {
    print("Statistic:")
    print("Calls count:\(callsCounter)")
    print("Conditionals count:\(conditionalCounter)")
}
