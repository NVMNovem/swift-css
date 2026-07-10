//
//  Time.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Time: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension Time: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension Time {

    static func milliseconds(_ value: Int) -> Self {
        .init("\(value)ms")
    }

    static func seconds(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))s")
    }
}
