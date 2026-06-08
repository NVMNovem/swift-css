//
//  JustifyContentValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct JustifyContentValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension JustifyContentValue {
    
    static let start: Self = .init("start")
    static let end: Self = .init("end")
    static let center: Self = .init("center")
    static let spaceBetween: Self = .init("space-between")
    static let spaceAround: Self = .init("space-around")
    static let spaceEvenly: Self = .init("space-evenly")
}
