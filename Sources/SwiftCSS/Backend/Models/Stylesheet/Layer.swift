//
//  Layer.swift
//  swift-css
//
//  Created by Codex on 12/06/2026.
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
    
    public func render(using renderer: CSSRenderer) {
        let header = if let name {
            "@layer \(name)"
        } else {
            "@layer"
        }
        
        CSSBlockRenderer.renderRenderableBlock(
            header: header,
            children: rules,
            using: renderer
        )
    }
}

public struct LayerOrder: CSSRenderable {
    
    public let names: [String]
    
    public init(names: [String]) {
        self.names = names
    }
    
    public func render(using renderer: CSSRenderer) {
        renderer.write("@layer ")
        renderer.write(names.joined(separator: ", "))
        renderer.write(";")
    }
}
