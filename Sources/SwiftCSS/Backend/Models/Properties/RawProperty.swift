//
//  RawProperty.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct RawProperty: CSSProperty {
    
    public let name: String
    public let value: String
    
    public init(
        _ name: String,
        _ value: String
    ) {
        self.name = name
        self.value = value
    }
}
