//
//  RowGap.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct RowGap: CSSProperty {
    
    public let name = "row-gap"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
