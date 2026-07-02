//
//  Outline.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct Outline: CSSProperty {
    
    public let name = "outline"
    public let value: String
    
    public init(_ value: OutlineValue) {
        self.value = value.rawValue
    }
}
