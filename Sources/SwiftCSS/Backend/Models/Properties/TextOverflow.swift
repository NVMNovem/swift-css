//
//  TextOverflow.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 28/08/2026.
//

/// The CSS `text-overflow` declaration.
///
/// Only takes effect on a block whose overflow is clipped and whose text does
/// not wrap, so pair it with ``Overflow`` and ``WhiteSpace``.
public struct TextOverflow: CSSProperty {

    public let name = "text-overflow"
    public let value: String

    public init(_ value: TextOverflowValue) {
        self.value = value.rawValue
    }
}
