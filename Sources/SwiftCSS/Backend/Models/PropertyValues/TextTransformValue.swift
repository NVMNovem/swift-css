//
//  TextTransformValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 30/06/2026.
//

public struct TextTransformValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension TextTransformValue {
    
    static let uppercase: Self = .init("uppercase")
    static let lowercase: Self = .init("lowercase")
    static let capitalize: Self = .init("capitalize")
    static let none: Self = .init("none")
}
