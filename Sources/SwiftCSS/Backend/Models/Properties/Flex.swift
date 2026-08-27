//
//  Flex.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public struct FlexGrow: CSSProperty {

    public let name = "flex-grow"
    public let value: String

    public init(_ value: Double) {
        self.value = formatCSSNumber(value)
    }
}

public struct FlexShrink: CSSProperty {

    public let name = "flex-shrink"
    public let value: String

    public init(_ value: Double) {
        self.value = formatCSSNumber(value)
    }
}

public struct FlexBasis: CSSProperty {

    public let name = "flex-basis"
    public let value: String

    public init(_ value: Length) {
        self.value = value.rawValue
    }

    public init(_ value: String) {
        self.value = value
    }
}
