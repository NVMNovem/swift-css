//
//  Angle.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Angle: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension Angle {
    
    static func deg(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))deg")
    }
    
    static func rad(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))rad")
    }
    
    static func turn(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))turn")
    }
}
