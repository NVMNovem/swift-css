//
//  Overflow.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct Overflow: CSSProperty {
    
    public let name = "overflow"
    public let value: String
    
    public init(_ value: OverflowValue) {
        self.value = value.rawValue
    }
}
