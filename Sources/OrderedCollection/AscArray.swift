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
    init(_ collection: AscArray<Element>) {
        self.init(collection.buffer)
    }
}
