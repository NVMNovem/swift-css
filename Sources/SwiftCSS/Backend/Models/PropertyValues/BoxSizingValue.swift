//
//  BoxSizingValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BoxSizingValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension BoxSizingValue {
    
    static let contentBox: Self = .init("content-box")
    static let borderBox: Self = .init("border-box")
}
