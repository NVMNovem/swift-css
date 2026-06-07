//
//  Length.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Length: Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension Length {
    
    static let zero: Self = .init("0")
    
    static func px(_ value: Int) -> Self {
        .init("\(value)px")
    }
    
    static func rem(_ value: Double) -> Self {
        .init("\(value)rem")
    }
    
    static func percent(_ value: Double) -> Self {
        .init("\(value)%")
    }
}
