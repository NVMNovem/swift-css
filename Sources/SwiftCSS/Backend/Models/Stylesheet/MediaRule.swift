//
//  MediaRule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MediaRule: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ condition: MediaCondition,
        @CSSBuilder rules: () -> [CSSNode]
    ) {
        self.cssNode = .media(.init(condition: condition.cssNode, children: rules()))
    }
}

public typealias Media = MediaRule
