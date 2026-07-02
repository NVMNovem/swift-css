//
//  Resize.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct Resize: CSSProperty {
    
    public let name = "resize"
    public let value: String
    
    public init(_ value: ResizeValue) {
        self.value = value.rawValue
    }
}
