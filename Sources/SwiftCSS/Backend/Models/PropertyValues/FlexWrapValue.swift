//
//  FlexWrapValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct FlexWrapValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension FlexWrapValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension FlexWrapValue {

    static let nowrap: Self = .init("nowrap")
    static let wrap: Self = .init("wrap")
    static let wrapReverse: Self = .init("wrap-reverse")
}
