//
//  Color.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Color: CSSValue, CSSProperty, Sendable, ExpressibleByStringLiteral {
    
    public let rawValue: String
    public let name = "color"
    
    public var value: String {
        rawValue
    }
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(_ value: Color) {
        self.rawValue = value.rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension Color {
    
    static let red: Self = .init("red")
    static let green: Self = .init("green")
    static let blue: Self = .init("blue")
    static let white: Self = .init("white")
    static let black: Self = .init("black")
    static let clear: Self = .init("transparent")
    
    static func css(_ value: String) -> Self {
        .init(value)
    }
    
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
