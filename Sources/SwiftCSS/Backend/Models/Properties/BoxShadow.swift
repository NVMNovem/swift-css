//
//  BoxShadow.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BoxShadow: CSSProperty {
    
    public let name = "box-shadow"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
