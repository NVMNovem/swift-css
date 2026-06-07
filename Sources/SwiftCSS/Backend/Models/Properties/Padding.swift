//
//  Padding.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Padding: CSSProperty {
    
    public let name = "padding"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
}
