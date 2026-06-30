//
//  BorderRadius.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct BorderRadius: CSSProperty {
    
    public let name = "border-radius"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
}
