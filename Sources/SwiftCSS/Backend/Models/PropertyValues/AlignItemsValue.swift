//
//  AlignItemsValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct AlignItemsValue: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension AlignItemsValue {
    
    static let stretch: Self = .init("stretch")
    static let center: Self = .init("center")
    static let flexStart: Self = .init("flex-start")
    static let flexEnd: Self = .init("flex-end")
    static let baseline: Self = .init("baseline")
}
