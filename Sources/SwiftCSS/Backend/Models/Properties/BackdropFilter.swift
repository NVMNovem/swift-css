//
//  BackdropFilter.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct BackdropFilter: CSSProperty {
    
    public let name = "backdrop-filter"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
