//
//  Position.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Position: CSSProperty {
    
    public let name = "position"
    public let value: String
    
    public init(_ value: PositionValue) {
        self.value = value.rawValue
    }
}
