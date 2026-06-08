//
//  TextDecorationValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct TextDecorationValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension TextDecorationValue {
    
    static let none: Self = .init("none")
    static let underline: Self = .init("underline")
    static let lineThrough: Self = .init("line-through")
}
