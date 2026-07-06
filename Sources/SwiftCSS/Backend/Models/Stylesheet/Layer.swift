//
//  Layer.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public struct Layer: CSSRenderable {
    
    public let name: String?
    public let rules: [any CSSRenderable]
    
    public init(
        _ name: String,
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.name = name
        self.rules = rules()
    }
    
    public init(
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.name = nil
        self.rules = rules()
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
    
    public init(names: [String]) {
        self.names = names
    }
}
