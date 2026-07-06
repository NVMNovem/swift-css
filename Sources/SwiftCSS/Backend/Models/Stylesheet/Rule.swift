//
//  Rule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Rule: CSSRenderable {
    
    let selector: Selector
    public let properties: [any CSSProperty]
    
    public init(
        _ selectorParts: SelectorPart...,
        @CSSPropertyBuilder properties: () -> [any CSSProperty]
    ) {
        self.init(
            selectorParts,
            properties: properties
        )
    }
    
    public init(
        _ selectorParts: [SelectorPart],
        @CSSPropertyBuilder properties: () -> [any CSSProperty]
    ) {
        self.selector = Selector(selectorParts)
        self.properties = properties()
    }
    
    public static func list(
        _ selectors: [[SelectorPart]],
        @CSSPropertyBuilder properties: () -> [any CSSProperty]
    ) -> Self {
        .init(
            selector: Selector(list: selectors),
            properties: properties()
        )
    }
    
    init(
        selector: Selector,
        properties: [any CSSProperty]
    ) {
        self.selector = selector
        self.properties = properties
    }
}
