//
//  LetterSpacing.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct LetterSpacing: CSSProperty {
    
    public let name = "letter-spacing"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
