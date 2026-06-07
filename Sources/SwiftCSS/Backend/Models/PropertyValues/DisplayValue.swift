//
//  DisplayValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct DisplayValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension DisplayValue {
    
    static let block: Self = .init("block")
    static let inline: Self = .init("inline")
    static let inlineBlock: Self = .init("inline-block")
    static let flex: Self = .init("flex")
    static let inlineFlex: Self = .init("inline-flex")
    static let grid: Self = .init("grid")
    static let inlineGrid: Self = .init("inline-grid")
    static let none: Self = .init("none")
}
