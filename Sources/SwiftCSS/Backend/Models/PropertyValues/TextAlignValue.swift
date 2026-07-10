//
//  TextAlignValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 30/06/2026.
//

public struct TextAlignValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension TextAlignValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension TextAlignValue {

    static let left: Self = .init("left")
    static let center: Self = .init("center")
    static let right: Self = .init("right")
    static let justify: Self = .init("justify")
}
