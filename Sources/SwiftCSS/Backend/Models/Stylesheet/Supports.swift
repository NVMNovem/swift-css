//
//  Supports.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
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
}

public struct SupportsCondition: Sendable {
    
    let query: Query
    
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

internal extension SupportsCondition {
    
    enum Query: Sendable {
        
        case property(String, String)
        case raw(String)
    }
}
