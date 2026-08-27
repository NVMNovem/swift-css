//
//  ObjectPosition.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 27/08/2026.
//

public struct ObjectPosition: CSSProperty {

    public let name = "object-position"
    public let value: String

    public init(_ value: String) {
        self.value = value
    }

    public init(x: Length, y: Length) {
        self.value = "\(x.rawValue) \(y.rawValue)"
    }
}
