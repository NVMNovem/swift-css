//
//  CSSProperty.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSProperty: CSSRenderable, Sendable {
    
    var name: String { get }
    var value: String { get }
}
