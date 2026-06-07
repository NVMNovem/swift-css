//
//  Width.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Width: CSSProperty {
    
    public let name = "width"
    public let value: String
    
    public init(_ value: CSSLength) {
        self.value = value.rawValue
    }
    
    public init(_ value: CSSPercentage) {
        self.value = value.rawValue
    }
}
