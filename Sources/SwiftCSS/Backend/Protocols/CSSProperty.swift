//
//  CSSProperty.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSProperty: CSSRenderable {
    
    var name: String { get }
    var value: String { get }
}

public extension CSSProperty {
    
    func render(using renderer: CSSRenderer) {
        if renderer.prettyPrinted {
            renderer.write(name)
            renderer.write(": ")
            renderer.write(value)
            renderer.write(";")
        } else {
            renderer.write(name)
            renderer.write(":")
            renderer.write(value)
            renderer.write(";")
        }
    }
}
