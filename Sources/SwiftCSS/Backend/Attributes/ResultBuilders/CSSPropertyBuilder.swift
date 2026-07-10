//
//  CSSPropertyBuilder.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

@resultBuilder
public enum CSSPropertyBuilder {

    public static func buildExpression<Declaration: CSSDeclarationConvertible>(_ expression: Declaration) -> [CSSDeclaration] {
        [expression.cssDeclaration]
    }

    public static func buildExpression(_ expression: CSSDeclaration) -> [CSSDeclaration] {
        [expression]
    }

    public static func buildBlock(_ components: [CSSDeclaration]...) -> [CSSDeclaration] {
        components.flatMap { $0 }
    }

    public static func buildArray(_ components: [[CSSDeclaration]]) -> [CSSDeclaration] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [CSSDeclaration]?) -> [CSSDeclaration] {
        component ?? []
    }

    public static func buildEither(first component: [CSSDeclaration]) -> [CSSDeclaration] {
        component
    }

    public static func buildEither(second component: [CSSDeclaration]) -> [CSSDeclaration] {
        component
    }
}
