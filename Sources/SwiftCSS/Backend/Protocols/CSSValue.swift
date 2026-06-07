//
//  CSSValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSValue {
    
    var rawValue: String { get }
}

func formatCSSNumber(_ value: Double) -> String {
    if value.rounded(.towardZero) == value {
        return String(Int(value))
    }
    
    return String(value)
}
