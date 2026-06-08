//
//  GridTemplateColumns.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct GridTemplateColumns: CSSProperty {
    
    public let name = "grid-template-columns"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
