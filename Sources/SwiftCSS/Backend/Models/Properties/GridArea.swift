//
//  GridArea.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 28/08/2026.
//

/// The CSS `grid-area` declaration.
///
/// A shorthand for up to four grid lines, and also the way an item is placed
/// into a named grid area, so its value stays a string rather than a closed
/// set of keywords.
public struct GridArea: CSSProperty {

    public let name = "grid-area"
    public let value: String

    public init(_ value: String) {
        self.value = value
    }
}
