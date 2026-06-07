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
    
    public func render(using renderer: CSSRenderer) {
        renderer.write(selector.rawValue)
        renderer.write(" {")
        
        if properties.isEmpty {
            renderer.write("}")
            return
        }
        
        if renderer.prettyPrinted {
            renderer.increaseIndentation()
            
            for property in properties {
                renderer.writeLineBreak()
                renderer.writeIndentation()
                property.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
            renderer.write("}")
        } else {
            for property in properties {
                property.render(using: renderer)
            }
            
            renderer.write("}")
        }
    }
}
