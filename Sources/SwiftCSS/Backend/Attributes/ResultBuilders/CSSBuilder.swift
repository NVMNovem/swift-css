//
//  CSSBuilder.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

@resultBuilder
public enum CSSBuilder {

    public static func buildExpression<Node: CSSNodeConvertible>(_ expression: Node) -> [CSSNode] {
        [expression.cssNode]
    }

    public static func buildExpression(_ expression: CSSNode) -> [CSSNode] {
        [expression]
    }

    public static func buildBlock(_ components: [CSSNode]...) -> [CSSNode] {
        components.flatMap { $0 }
    }

    public static func buildArray(_ components: [[CSSNode]]) -> [CSSNode] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [CSSNode]?) -> [CSSNode] {
        component ?? []
    }

    public static func buildEither(first component: [CSSNode]) -> [CSSNode] {
        component
    }

    public static func buildEither(second component: [CSSNode]) -> [CSSNode] {
        component
    }
}
