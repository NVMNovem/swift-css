//
//  WhiteSpaceValue.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 28/08/2026.
//

public enum WhiteSpaceValue: String, CSSValue, Sendable {

    case normal
    case nowrap
    case pre
    case preWrap = "pre-wrap"
    case preLine = "pre-line"

    /// Preserves white space and line breaks, and wraps like `pre-wrap`, except
    /// that a sequence of preserved spaces at the end of a line does not hang
    /// past the content box and still takes up space.
    case breakSpaces = "break-spaces"
}
