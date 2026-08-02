//
//  LineHeight.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

/// The CSS `line-height` declaration.
///
/// Prefer a unitless ``LineHeightValue/multiple(_:)`` so descendants scale the
/// inherited multiplier using their own font size.
public struct LineHeight: CSSProperty {
    
    public let name = "line-height"
    public let value: String
    
    /// Creates a line-height declaration from a typed value.
    public init(_ value: LineHeightValue) {
        self.value = value.rawValue
    }
    
    /// Creates a line-height declaration from raw CSS.
    public init(_ value: String) {
        self.value = value
    }
}
