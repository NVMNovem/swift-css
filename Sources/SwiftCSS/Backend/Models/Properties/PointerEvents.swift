//
//  PointerEvents.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct PointerEvents: CSSProperty {
    
    public let name = "pointer-events"
    public let value: String
    
    public init(_ value: PointerEventsValue) {
        self.value = value.rawValue
    }
}
