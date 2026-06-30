//
//  TextAlign.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 30/06/2026.
//

public struct TextAlign: CSSProperty {
    
    public let name = "text-align"
    public let value: String
    
    public init(_ value: TextAlignValue) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
