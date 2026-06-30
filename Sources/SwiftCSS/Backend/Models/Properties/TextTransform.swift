//
//  TextTransform.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 30/06/2026.
//

public struct TextTransform: CSSProperty {
    
    public let name = "text-transform"
    public let value: String
    
    public init(_ value: TextTransformValue) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
