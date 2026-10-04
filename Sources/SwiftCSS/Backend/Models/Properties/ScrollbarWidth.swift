//
//  ScrollbarWidth.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 04/10/2026.
//

public struct ScrollbarWidth: CSSProperty {
    
    public let name = "scrollbar-width"
    public let value: String
    
    public init(_ value: ScrollbarWidthValue) {
        self.value = value.rawValue
    }
}
