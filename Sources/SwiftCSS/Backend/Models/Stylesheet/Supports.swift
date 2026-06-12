//
//  Supports.swift
//  swift-css
//
//  Created by Codex on 12/06/2026.
//

public struct Supports: CSSRenderable {
    
    public let condition: SupportsCondition
    public let rules: [any CSSRenderable]
    
    public init(
        _ condition: SupportsCondition,
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.condition = condition
        self.rules = rules()
    }
    
    public func render(using renderer: CSSRenderer) {
        CSSBlockRenderer.renderRenderableBlock(
            header: "@supports \(condition.rawValue(prettyPrinted: renderer.prettyPrinted))",
            children: rules,
            using: renderer
        )
    }
}

public struct SupportsCondition: Sendable {
    
    private let query: Query
    
    private init(_ query: Query) {
        self.query = query
    }
}

public extension SupportsCondition {
    
    static func raw(_ value: String) -> Self {
        .init(.raw(value))
    }
    
    static func property(
        _ name: String,
        _ value: String
    ) -> Self {
        .init(.property(name, value))
    }
    
    static func display(_ value: String) -> Self {
        .property("display", value)
    }
    
    static func display(_ value: DisplayValue) -> Self {
        .display(value.rawValue)
    }
}

private extension SupportsCondition {
    
    enum Query: Sendable {
        
        case property(String, String)
        case raw(String)
    }
    
    func rawValue(prettyPrinted: Bool) -> String {
        switch query {
        case let .property(name, value):
            let separator = prettyPrinted ? ": " : ":"
            
            return "(\(name)\(separator)\(value))"
        case let .raw(value):
            return value
        }
    }
}
