//
//  Supports.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public struct Supports: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        _ condition: SupportsCondition,
        @CSSBuilder rules: () -> [CSSNode]
    ) {
        self.cssNode = .supports(.init(condition: condition.cssNode, children: rules()))
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

    var cssNode: CSSConditionNode {
        switch query {
        case let .property(name, value):
            .feature(name: name, value: value)
        case let .raw(value):
            .raw(value)
        }
    }
    
    enum Query: Sendable {
        
        case property(String, String)
        case raw(String)
    }
}
