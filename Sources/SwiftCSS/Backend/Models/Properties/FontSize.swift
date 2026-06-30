//
//  FontSize.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct FontSize: CSSProperty {
    
    public let name = "font-size"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
}
