//
//  Keyframes.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public struct Keyframes: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ name: String,
        @CSSBuilder frames: () -> [CSSNode]
    ) {
        self.cssNode = .keyframes(.init(name: name, frames: frames()))
    }
}

public struct Keyframe: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ selector: KeyframeSelector,
        @CSSPropertyBuilder properties: () -> [CSSDeclaration]
    ) {
        self.cssNode = .keyframe(
            .init(selector: selector.cssNode, declarations: properties())
        )
    }
}

public enum KeyframeSelector: Sendable {
    
    case from
    case to
    case percent(Int)
    case raw(String)
}

private extension KeyframeSelector {
    var cssNode: CSSKeyframeSelectorNode {
        switch self {
        case .from:
            .from
        case .to:
            .to
        case let .percent(value):
            .percent(value)
        case let .raw(value):
            .raw(value)
        }
    }
}
