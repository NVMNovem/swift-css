//
//  Cursor.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct Cursor: CSSProperty {
    
    public let name = "cursor"
    public let value: String
    
    public init(_ value: CursorValue) {
        self.value = value.rawValue
    }
}
