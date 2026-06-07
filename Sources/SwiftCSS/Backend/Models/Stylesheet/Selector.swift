//
//  Selector.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Selector: Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension Selector {
    
    static func `class`(_ value: String) -> Self {
        .init(".\(value)")
    }
    
    static func id(_ value: String) -> Self {
        .init("#\(value)")
    }
    
    static func element(_ value: String) -> Self {
        .init(value)
    }
}
