//
//  Opacity.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Opacity: CSSProperty {
    
    public let name = "opacity"
    public let value: String
    
    public init(_ value: Double) {
        self.value = formatCSSNumber(value)
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
