//
//  ObjectFit.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 02/07/2026.
//

public struct ObjectFit: CSSProperty {
    
    public let name = "object-fit"
    public let value: String
    
    public init(_ value: ObjectFitValue) {
        self.value = value.rawValue
    }
}
