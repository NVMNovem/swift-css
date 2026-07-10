//
//  CSSProperty.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSDeclarationConvertible: Sendable {
    var cssDeclaration: CSSDeclaration { get }
}

public protocol CSSProperty: CSSDeclarationConvertible, CSSNodeConvertible, Sendable {
    
    var name: String { get }
    var value: String { get }
}

public extension CSSProperty {
    var cssDeclaration: CSSDeclaration {
        .property(.init(property: name, value: value))
    }

    var cssNode: CSSNode {
        .declaration(cssDeclaration)
    }
}
