//
//  CSSColor.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct CSSColor: CSSValue, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension CSSColor {
    
    static let red: Self = .init("red")
    static let green: Self = .init("green")
    static let blue: Self = .init("blue")
    static let white: Self = .init("white")
    static let black: Self = .init("black")
    
    static func hex(_ value: String) -> Self {
        .init(value.hasPrefix("#") ? value : "#\(value)")
    }
    
    static func rgb(
        red: Int,
        green: Int,
        blue: Int
    ) -> Self {
        .init("rgb(\(red), \(green), \(blue))")
    }
    
    static func rgba(
        red: Int,
        green: Int,
        blue: Int,
        alpha: Double
    ) -> Self {
        .init("rgba(\(red), \(green), \(blue), \(alpha))")
    }
}
