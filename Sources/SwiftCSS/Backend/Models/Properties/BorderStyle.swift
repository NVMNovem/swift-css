//
//  BorderStyle.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BorderStyle: CSSProperty {
    
    public let name = "border-style"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
