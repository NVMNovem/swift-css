//
//  AlignItemsValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct AlignItemsValue: CSSValue, Sendable {

    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension AlignItemsValue: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension AlignItemsValue {

    static let start: Self = .init("start")
    static let end: Self = .init("end")

    static let flexStart: Self = .init("flex-start")
    static let flexEnd: Self = .init("flex-end")

    static let center: Self = .init("center")
    static let stretch: Self = .init("stretch")

    static let baseline: Self = .init("baseline")
}
