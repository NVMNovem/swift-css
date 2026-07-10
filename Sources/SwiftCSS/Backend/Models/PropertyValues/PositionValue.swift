//
//  PositionValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct PositionValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension PositionValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension PositionValue {

    static let `static`: Self = .init("static")
    static let relative: Self = .init("relative")
    static let absolute: Self = .init("absolute")
    static let fixed: Self = .init("fixed")
    static let sticky: Self = .init("sticky")
}
