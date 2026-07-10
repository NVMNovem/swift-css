//
//  Layer.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public struct Layer: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ name: String,
        @CSSBuilder rules: () -> [CSSNode]
    ) {
        self.cssNode = .layer(.init(name: name, children: rules()))
    }
    
    public init(
        @CSSBuilder rules: () -> [CSSNode]
    ) {
        self.cssNode = .layer(.init(name: nil, children: rules()))
    }
    
    public static func order(_ names: String...) -> LayerOrder {
        .init(names: names)
    }
    
    public static func order(_ names: [String]) -> LayerOrder {
        .init(names: names)
    }
}

public struct LayerOrder: CSSRenderable {

    public let names: [String]

    public var cssNode: CSSNode {
        .layerOrder(.init(names: names))
    }
    
    public init(names: [String]) {
        self.names = names
    }
}
