//
//  AlignSelfValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public struct AlignSelfValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension AlignSelfValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension AlignSelfValue {

    /// Defers to the container's `align-items`.
    ///
    /// This is the one keyword `align-items` itself does not accept, and the
    /// reason `align-self` has its own value type rather than reusing
    /// ``AlignItemsValue``.
    static let auto: Self = .init("auto")

    static let start: Self = .init("start")
    static let end: Self = .init("end")

    static let flexStart: Self = .init("flex-start")
    static let flexEnd: Self = .init("flex-end")

    static let center: Self = .init("center")
    static let stretch: Self = .init("stretch")

    static let baseline: Self = .init("baseline")
}
