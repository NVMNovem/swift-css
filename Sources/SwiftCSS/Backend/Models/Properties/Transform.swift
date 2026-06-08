//
//  Transform.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Transform: CSSProperty {
    
    public let name = "transform"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
