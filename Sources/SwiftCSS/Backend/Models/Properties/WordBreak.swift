//
//  WordBreak.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public struct WordBreak: CSSProperty {

    public let name = "word-break"
    public let value: String

    public init(_ value: WordBreakValue) {
        self.value = value.rawValue
    }
}
