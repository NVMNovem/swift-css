//
//  CSSLength.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct CSSLength: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension CSSLength {
    
    static let zero: Self = .init("0")
    
    static func px(_ value: Int) -> Self {
        .init("\(value)px")
    }
    
    static func em(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))em")
    }
    
    static func rem(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))rem")
    }
    
    static func vh(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))vh")
    }
    
    static func vw(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))vw")
    }
    
    static func fr(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))fr")
    }
    
    static func ch(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))ch")
    }
}
