//
//  Color.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Color: CSSProperty {
    
    public let name = "color"
    public let value: String
    
    public init(_ value: CSSColor) {
        self.value = value.rawValue
    }
}
