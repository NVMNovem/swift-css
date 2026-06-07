//
//  Declaration.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Declaration: CSSRenderable, Sendable {
    
    public let property: String
    public let value: String
    
    public init(
        _ property: String,
        _ value: String
    ) {
        self.property = property
        self.value = value
    }
    
    public func render(using renderer: CSSRenderer) {
        if renderer.prettyPrinted {
            renderer.write(property)
            renderer.write(": ")
            renderer.write(value)
            renderer.write(";")
        } else {
            renderer.write(property)
            renderer.write(":")
            renderer.write(value)
            renderer.write(";")
        }
    }
}

public extension Declaration {
    
    static func color(_ value: Color) -> Self {
        .init("color", value.rawValue)
    }
    
    static func background(_ value: String) -> Self {
        .init("background", value)
    }
    
    static func backgroundColor(_ value: Color) -> Self {
        .init("background-color", value.rawValue)
    }
    
    static func padding(_ value: Length) -> Self {
        .init("padding", value.rawValue)
    }
    
    static func margin(_ value: Length) -> Self {
        .init("margin", value.rawValue)
    }
    
    static func borderRadius(_ value: Length) -> Self {
        .init("border-radius", value.rawValue)
    }
    
    static func fontSize(_ value: Length) -> Self {
        .init("font-size", value.rawValue)
    }
    
    static func fontWeight(_ value: String) -> Self {
        .init("font-weight", value)
    }
    
    static func display(_ value: String) -> Self {
        .init("display", value)
    }
    
    static func gap(_ value: Length) -> Self {
        .init("gap", value.rawValue)
    }
}
