//
//  Keyframes.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public struct Keyframes: CSSRenderable {
    
    public let name: String
    public let frames: [any CSSRenderable]
    
    public init(
        _ name: String,
        @CSSBuilder frames: () -> [any CSSRenderable]
    ) {
        self.name = name
        self.frames = frames()
    }
}

public struct Keyframe: CSSRenderable {
    
    public let selector: KeyframeSelector
    public let properties: [any CSSProperty]
    
    public init(
        _ selector: KeyframeSelector,
        @CSSPropertyBuilder properties: () -> [any CSSProperty]
    ) {
        self.selector = selector
        self.properties = properties()
    }
}

public enum KeyframeSelector: Sendable {
    
    case from
    case to
    case percent(Int)
    case raw(String)
}
