//
//  CSSPropertyBuilder.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

@resultBuilder
public enum CSSPropertyBuilder {
    
    public static func buildExpression<Property: CSSProperty>(_ expression: Property) -> any CSSProperty {
        expression
    }
    
    public static func buildExpression(_ expression: any CSSProperty) -> any CSSProperty {
        expression
    }
    
    public static func buildBlock(_ components: any CSSProperty...) -> [any CSSProperty] {
        components
    }
    
    public static func buildArray(_ components: [[any CSSProperty]]) -> [any CSSProperty] {
        components.flatMap(\.self)
    }
    
    public static func buildOptional(_ component: [any CSSProperty]?) -> [any CSSProperty] {
        component ?? []
    }
    
    public static func buildEither(first component: [any CSSProperty]) -> [any CSSProperty] {
        component
    }
    
    public static func buildEither(second component: [any CSSProperty]) -> [any CSSProperty] {
        component
    }
}
