//
//  OverflowValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct OverflowValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension OverflowValue {
    
    static let visible: Self = .init("visible")
    static let hidden: Self = .init("hidden")
    static let scroll: Self = .init("scroll")
    static let auto: Self = .init("auto")
    static let clip: Self = .init("clip")
}
