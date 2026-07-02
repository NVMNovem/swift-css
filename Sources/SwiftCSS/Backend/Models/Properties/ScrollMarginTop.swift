//
//  ScrollMarginTop.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct ScrollMarginTop: CSSProperty {
    
    public let name = "scroll-margin-top"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
}
