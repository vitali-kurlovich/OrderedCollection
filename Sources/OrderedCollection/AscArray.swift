//
//  AscArray.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation

public
typealias AscArray<Element: Comparable> = AscCollection<Element, [Element]>

public
typealias AscArraySlice<Element: Comparable> = AscCollection<Element, ArraySlice<Element>>

public
typealias ReversedAscCollection<Element: Comparable> = AscCollection<Element, ReversedCollection<[Element]>>

extension Array where Element: Comparable {
    public
    typealias Index = Int
    
    public
    typealias Indices = Range<Int>
    
    public subscript(position: Int) -> ElementType {
        return buffer[position]
    }
    
    public func index(before i: Int) -> Int {
        return buffer.index(before: i)
    }
    
    public func index(after i: Int) -> Int {
        return buffer.index(after: i)
    }
    
    public var startIndex: Int {
        return buffer.startIndex
    }
}
