//
//  TextAlignValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 30/06/2026.
//

public struct TextAlignValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension TextAlignValue {
    
    static let left: Self = .init("left")
    static let center: Self = .init("center")
    static let right: Self = .init("right")
    static let justify: Self = .init("justify")
}
