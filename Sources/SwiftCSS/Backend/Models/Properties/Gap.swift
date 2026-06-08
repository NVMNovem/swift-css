//
//  Gap.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Gap: CSSProperty {
    
    public let name = "gap"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
