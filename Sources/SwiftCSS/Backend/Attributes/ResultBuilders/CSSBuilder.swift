//
//  CSSBuilder.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

@resultBuilder
public enum CSSBuilder {
    
    public static func buildBlock(_ components: any CSSRenderable...) -> [any CSSRenderable] {
        components
    }
    
    public static func buildArray(_ components: [[any CSSRenderable]]) -> [any CSSRenderable] {
        components.flatMap(\.self)
    }
    
    public static func buildOptional(_ component: [any CSSRenderable]?) -> [any CSSRenderable] {
        component ?? []
    }
    
    public static func buildEither(first component: [any CSSRenderable]) -> [any CSSRenderable] {
        component
    }
    
    public static func buildEither(second component: [any CSSRenderable]) -> [any CSSRenderable] {
        component
    }
}
