//
//  GridTemplateRows.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct GridTemplateRows: CSSProperty {
    
    public let name = "grid-template-rows"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
