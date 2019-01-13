//
//  AscArray.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/13/19.
//

import Foundation



public
struct AscArray<ElementType: Comparable> {
    private
    var buffer: [ElementType]
    
    internal
    init(buffer: [ElementType]) {
        self.buffer = buffer
    }
}

extension AscArray: OrderedCollection {
    public
    var isAscending: Bool {
        return true
    }
}

extension AscArray {
    public
    init<S>(_ sequence: S) throws where ElementType == S.Element, S: Sequence {
        var last: ElementType?
        for element in sequence {
            guard last != nil else {
                last = element
                continue
            }
            
            if last! > element {
                throw OrderedCollectionError.IncorrectOrderError
            }
            last = element
        }
        
        self.init(buffer: Array<Element>(sequence))
    }
    
    public
    init(_ array: [ElementType]) throws {
        if array.count > 2 {
            var last = array.first!
            for element in array {
                if last > element {
                    throw OrderedCollectionError.IncorrectOrderError
                }
                last = element
            }
        }
 
        self.init(buffer: array)
    }
    
    public
    init(_ asc:AscArray<ElementType>) {
        self.init(buffer: asc.buffer)
    }
    
    public
    init() {
        self.init(buffer: [ElementType]())
    }
}

// Mutations
extension AscArray {
    public
    mutating func append(element: Element) throws {
        guard let last = self.last else {
            buffer.append(element)
            return
        }
        
        guard last <= element else {
            throw OrderedCollectionError.IncorrectValueError
        }

        buffer.append(element)
    }
    
    public
    mutating func append<S>(contentsOf newElements: S) throws where Element == S.Element, S : Sequence {
        for element in newElements {
            try append(element: element)
        }
    }
    
    public
    mutating func append(contentsOf newElements: AscArray<ElementType>) throws  {
        guard newElements.count > 0 else {return}
        
        if count == 0 {
            buffer = newElements.buffer
            return
        }
        
        let first = newElements.first!
        guard last! <= first else {
            throw OrderedCollectionError.IncorrectValueError
        }
        
        buffer.append(contentsOf: newElements.buffer)
    }
    
    public
    mutating func insert(_ newElement: ElementType, at i: Index) throws {
        let before = index(before: i)
        let after = index(after: i)
        
        if before >= startIndex {
            let left = self[before]
            guard left <= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }
        
        if after <= self.endIndex {
            let right = self[after]
            guard right >= newElement else {
                throw OrderedCollectionError.IncorrectValueError
            }
        }
        
        buffer.insert(newElement, at: i)
    }
    
    public
    mutating func remove(at index: Index) -> ElementType {
        return buffer.remove(at: index)
    }
    
    public
    mutating func removeLast() -> ElementType {
        return buffer.removeLast()
    }
    
}


extension AscArray {
    public
    var isEmpty: Bool { return buffer.isEmpty }
    
    public
    var count: Int {
        return buffer.count
    }
    
    public
    var capacity: Int {
        return buffer.capacity
    }
    
    public mutating
    func reserveCapacity(_ minimumCapacity: Int) {
        buffer.reserveCapacity(minimumCapacity)
    }
}


/*
extension AscArray {
    public
    subscript(bounds: Indices) -> AscArray<Element> {
        get {
            let slice = buffer[bounds]
            return AscArray(buffer: slice)
        }
    }
}
 */

extension AscArray: Equatable {
    public
    static func == (lhs: AscArray<Element>, rhs: AscArray<Element>) -> Bool {
        return lhs.buffer == rhs.buffer
    }
    
    public
    static func == (lhs: Array<Element>, rhs: AscArray<Element>) -> Bool {
        return lhs == rhs.buffer
    }
    
    public
    static func == (lhs: AscArray<Element>, rhs: Array<Element>) -> Bool {
        return lhs.buffer == rhs
    }
}

extension AscArray : BidirectionalCollection {
    
    public
    typealias Element = ElementType
    
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
    
    public var endIndex: Int {
        return buffer.endIndex
    }
    
    public var indices: Range<Int> {
        return buffer.indices
    }
    
}


