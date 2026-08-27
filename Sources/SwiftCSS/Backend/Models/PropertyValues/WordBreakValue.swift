//
//  WordBreakValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public enum WordBreakValue: String, CSSValue, Sendable {

    case normal
    case breakAll = "break-all"
    case keepAll = "keep-all"

    /// Breaks a word only where it would otherwise overflow its line.
    ///
    /// Deprecated by the specification, which redefines it as a legacy alias for
    /// `overflow-wrap: anywhere`. It is kept because the two are not
    /// interchangeable in practice: `word-break: break-word` is honoured by every
    /// engine in use, and it is still the shortest way to say "wrap a token that
    /// has no break opportunity".
    case breakWord = "break-word"
}
