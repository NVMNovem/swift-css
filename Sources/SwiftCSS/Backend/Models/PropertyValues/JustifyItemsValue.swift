//
//  JustifyItemsValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 28/08/2026.
//

public struct JustifyItemsValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension JustifyItemsValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension JustifyItemsValue {

    static let start: Self = .init("start")
    static let end: Self = .init("end")

    static let flexStart: Self = .init("flex-start")
    static let flexEnd: Self = .init("flex-end")

    static let left: Self = .init("left")
    static let right: Self = .init("right")

    static let center: Self = .init("center")
    static let stretch: Self = .init("stretch")

    static let baseline: Self = .init("baseline")
}
