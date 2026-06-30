//
//  LineHeight.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct LineHeight: CSSProperty {
    
    public let name = "line-height"
    public let value: String
    
    public init(_ value: Double) {
        self.value = formatCSSNumber(value)
    }
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
