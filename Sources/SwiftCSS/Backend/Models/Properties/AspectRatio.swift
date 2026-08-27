//
//  AspectRatio.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public struct AspectRatio: CSSProperty {

    public let name = "aspect-ratio"
    public let value: String

    public init(_ ratio: Double) {
        self.value = formatCSSNumber(ratio)
    }

    /// Creates an aspect ratio from its two terms.
    ///
    /// This is the form CSS prefers and the one a reader recognises:
    /// `AspectRatio(3, 2)` renders `3 / 2` rather than `1.5`. The two forms are
    /// equivalent to a browser and are not equivalent to a person.
    public init(_ width: Double, _ height: Double) {
        self.value = "\(formatCSSNumber(width)) / \(formatCSSNumber(height))"
    }

    /// Creates an aspect ratio from raw CSS.
    ///
    /// Use this for `auto`, or for any form this type does not model, such as
    /// `auto 3 / 2`, a custom property, or `inherit`.
    public init(_ value: String) {
        self.value = value
    }
}
