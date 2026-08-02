//
//  LineHeightValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/08/2026.
//

/// A value accepted by the CSS `line-height` property.
///
/// Use ``multiple(_:)`` for a unitless multiplier. CSS requires multipliers
/// and percentages to be finite and non-negative; like other SwiftCSS numeric
/// helpers, these constructors leave validation to the caller.
public struct LineHeightValue: CSSValue, Sendable {

    public let rawValue: String

    /// Creates a line-height value from raw CSS.
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension LineHeightValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension LineHeightValue {

    /// The user agent's normal line height.
    static let normal: Self = .init("normal")

    /// A unitless multiplier of the element's own font size.
    static func multiple(_ value: Double) -> Self {
        .init(formatCSSNumber(value))
    }

    /// An explicit CSS length.
    static func length(_ value: Length) -> Self {
        .init(value.rawValue)
    }

    /// A percentage of the element's font size.
    static func percent(_ value: Double) -> Self {
        .init("\(formatCSSNumber(value))%")
    }
}
