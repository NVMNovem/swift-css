//
//  LineClamp.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 04/10/2026.
//

/// The CSS `line-clamp` declaration: at most this many lines, the last ending
/// in an ellipsis.
///
/// This is the standard property, and no browser honours it alone yet. What
/// they honour is the prefixed form, which only works as a set of four:
///
/// ```swift
/// Display(.webkitBox)
/// WebkitBoxOrient(.vertical)
/// WebkitLineClamp(2)
/// Overflow(.hidden)
/// ```
///
/// State this one beside them, so the day a browser reads it the rule is
/// already there.
public struct LineClamp: CSSProperty {

    public let name = "line-clamp"
    public let value: String

    public init(_ lines: Int) {
        self.value = "\(lines)"
    }

    public init(_ value: String) {
        self.value = value
    }
}

/// The CSS `-webkit-line-clamp` declaration.
///
/// Despite the prefix it is the form every engine implements, Firefox
/// included. It takes effect only on a box that is `display: -webkit-box`
/// (``DisplayValue/webkitBox``) with ``WebkitBoxOrient`` vertical and its
/// overflow hidden — see ``LineClamp``.
public struct WebkitLineClamp: CSSProperty {

    public let name = "-webkit-line-clamp"
    public let value: String

    public init(_ lines: Int) {
        self.value = "\(lines)"
    }

    public init(_ value: String) {
        self.value = value
    }
}

/// The CSS `-webkit-box-orient` declaration.
///
/// Part of the old flexbox draft, and kept alive by browsers for exactly one
/// reason: ``WebkitLineClamp`` does nothing without it set to vertical.
public struct WebkitBoxOrient: CSSProperty {

    public let name = "-webkit-box-orient"
    public let value: String

    public init(_ value: BoxOrientValue) {
        self.value = value.rawValue
    }
}
