//
//  BorderColor.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BorderColor: CSSProperty {
    
    public let name = "border-color"
    public let value: String
    
    public init(_ value: Color) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
