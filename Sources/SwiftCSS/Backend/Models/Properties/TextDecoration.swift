//
//  TextDecoration.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct TextDecoration: CSSProperty {
    
    public let name = "text-decoration"
    public let value: String
    
    public init(_ value: TextDecorationValue) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
