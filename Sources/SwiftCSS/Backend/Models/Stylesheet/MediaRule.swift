//
//  MediaRule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MediaRule: CSSRenderable {
    
    public let condition: MediaCondition
    public let rules: [any CSSRenderable]
    
    public init(
        _ condition: MediaCondition,
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.condition = condition
        self.rules = rules()
    }
    
    public func render(using renderer: CSSRenderer) {
        CSSBlockRenderer.renderRenderableBlock(
            header: "@media \(condition.rawValue(prettyPrinted: renderer.prettyPrinted))",
            children: rules,
            using: renderer
        )
    }
}

public typealias Media = MediaRule
