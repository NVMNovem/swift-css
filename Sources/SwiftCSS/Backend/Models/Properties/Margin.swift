//
//  Margin.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Margin: CSSProperty {
    
    public let name = "margin"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
}
