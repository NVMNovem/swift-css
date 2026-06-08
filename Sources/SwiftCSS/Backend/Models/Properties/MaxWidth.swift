//
//  MaxWidth.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MaxWidth: CSSProperty {
    
    public let name = "max-width"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
    
    public init(_ value: CSSPercentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
