//
//  WhiteSpace.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 28/08/2026.
//

public struct WhiteSpace: CSSProperty {

    public let name = "white-space"
    public let value: String

    public init(_ value: WhiteSpaceValue) {
        self.value = value.rawValue
    }
}
