//
//  TypeKey.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 09/04/24.
//

import Foundation

// MARK: - TypeKey
struct TypeKey: Codable {
    let key: String?
    let type: String?
    let value: String?
}

// MARK: - TypeKeyEnum
enum TypeKeyEnum: Codable {
    case string(String)
    case typeKey(TypeKey)
    
    init(from decoder: Decoder) throws {
        if let string = try? String(from: decoder) {
            self = .string(string)
            return
        }
        if let typeKey = try? TypeKey(from: decoder) {
            self = .typeKey(typeKey)
            return
        }
        throw DecodingError.dataCorruptedError(in: try decoder.unkeyedContainer(), debugDescription: "Unable to decode TypeKeyEnum")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .typeKey(let typeKey):
            try container.encode(typeKey)
        }
    }
}
