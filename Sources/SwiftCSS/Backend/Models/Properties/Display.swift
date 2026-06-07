//
//  Display.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Display: CSSProperty {
    
    public let name = "display"
    public let value: String
    
    public init(_ value: DisplayValue) {
        self.value = value.rawValue
    }
}
