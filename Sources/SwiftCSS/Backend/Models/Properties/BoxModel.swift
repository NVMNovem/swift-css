//
//  BoxModel.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BoxSizing: CSSProperty {
    
    public let name = "box-sizing"
    public let value: String
    
    public init(_ value: BoxSizingValue) {
        self.value = value.rawValue
    }
}
