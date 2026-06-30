//
//  TransitionDuration.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct TransitionDuration: CSSProperty {
    
    public let name = "transition-duration"
    public let value: String
    
    public init(_ value: Time) {
        self.value = value.rawValue
    }
}
