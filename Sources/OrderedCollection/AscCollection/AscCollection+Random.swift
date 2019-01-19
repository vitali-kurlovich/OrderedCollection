//
//  AscCollection+Random.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/19/19.
//

extension AscCollection: RandomElementProtocol where Buffer: RandomElementProtocol {
    public
    func randomElement<T>(using generator: inout T) -> Element? where T: RandomNumberGenerator {
        return buffer.randomElement(using: &generator)
    }

    public
    func randomElement() -> Element? {
        return buffer.randomElement()
    }
}
