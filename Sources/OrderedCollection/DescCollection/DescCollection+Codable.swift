//
//  DescCollection+Codable.swift
//  OrderedCollection
//
//  Created by Vitali Kurlovich on 1/21/19.
//

extension DescCollection: Encodable where Buffer: Encodable {
    public func encode(to encoder: Encoder) throws {
        try buffer.encode(to: encoder)
    }
}

extension DescCollection: Decodable where Buffer: Decodable {
    public init(from decoder: Decoder) throws {
        let buffer = try Buffer(from: decoder)
        self.init(buffer: buffer)
    }
}
