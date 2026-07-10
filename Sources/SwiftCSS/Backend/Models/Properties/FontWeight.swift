//
//  FontWeight.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct FontWeight: CSSProperty {

    public struct Value: CSSValue, Sendable {

        public let rawValue: String

        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }

    public let name = "font-weight"
    public let value: String

    public init(_ value: Value) {
        self.value = value.rawValue
    }
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
extension FontWeight.Value: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
#endif

public extension FontWeight.Value {

    static let normal: Self = .init("normal")
    static let bold: Self = .init("bold")
    static let lighter: Self = .init("lighter")
    static let bolder: Self = .init("bolder")

    static func weight(_ value: Int) -> Self {
        .init("\(value)")
    }
}
