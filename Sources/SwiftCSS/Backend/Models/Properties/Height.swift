//
//  Height.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Height: CSSProperty {
    
    public let name = "height"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
}
