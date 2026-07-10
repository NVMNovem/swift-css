//
//  TextDecorationValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct TextDecorationValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension TextDecorationValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension TextDecorationValue {

    static let none: Self = .init("none")
    static let underline: Self = .init("underline")
    static let overline: Self = .init("overline")
    static let lineThrough: Self = .init("line-through")
}
