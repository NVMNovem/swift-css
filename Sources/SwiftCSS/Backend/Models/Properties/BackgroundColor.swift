//
//  BackgroundColor.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct BackgroundColor: CSSProperty {
    
    public let name = "background-color"
    public let value: String
    
    public init(_ value: Color) {
        self.value = value.rawValue
    }
}
