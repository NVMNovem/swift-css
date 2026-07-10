//
//  Percentage.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Percentage: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension Percentage: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension Percentage {

    static let zero: Self = .init("0%")

    static func percent(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))%")
    }
}
