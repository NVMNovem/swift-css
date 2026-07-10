//
//  Rule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Rule: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ selectorParts: SelectorPart...,
        @CSSPropertyBuilder properties: () -> [CSSDeclaration]
    ) {
        self.init(
            selectorParts,
            properties: properties
        )
    }
    
    public init(
        _ selectorParts: [SelectorPart],
        @CSSPropertyBuilder properties: () -> [CSSDeclaration]
    ) {
        self.cssNode = .rule(
            .init(
                selector: Selector(selectorParts).cssNode,
                declarations: properties()
            )
        )
    }
    
    public static func list(
        _ selectors: [[SelectorPart]],
        @CSSPropertyBuilder properties: () -> [CSSDeclaration]
    ) -> Self {
        .init(
            selector: Selector(list: selectors).cssNode,
            declarations: properties()
        )
    }
    
    init(
        selector: CSSSelectorNode,
        declarations: [CSSDeclaration]
    ) {
        self.cssNode = .rule(.init(selector: selector, declarations: declarations))
    }
}
