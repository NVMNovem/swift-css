//
//  MinWidth.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MinWidth: CSSProperty {
    
    public let name = "min-width"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
