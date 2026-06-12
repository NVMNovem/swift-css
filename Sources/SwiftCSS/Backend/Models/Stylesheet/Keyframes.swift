//
//  Keyframes.swift
//  swift-css
//
//  Created by Codex on 12/06/2026.
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
    
    public func render(using renderer: CSSRenderer) {
        CSSBlockRenderer.renderRenderableBlock(
            header: "@keyframes \(name)",
            children: frames,
            using: renderer
        )
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
    
    public func render(using renderer: CSSRenderer) {
        CSSBlockRenderer.renderPropertyBlock(
            header: selector.rawValue,
            properties: properties,
            using: renderer
        )
    }
}

public enum KeyframeSelector: Sendable {
    
    case from
    case to
    case percent(Int)
    case raw(String)
}

public extension KeyframeSelector {
    
    var rawValue: String {
        switch self {
        case .from:
            "from"
        case .to:
            "to"
        case let .percent(value):
            "\(value)%"
        case let .raw(value):
            value
        }
    }
}
