//
//  CursorValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public enum CursorValue: String, CSSValue, Sendable {
    
    case pointer
    case `default`
    case text
    case notAllowed = "not-allowed"
    case grab
    case grabbing
}
