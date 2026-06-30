//
//  MinHeight.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MinHeight: CSSProperty {
    
    public let name = "min-height"
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
