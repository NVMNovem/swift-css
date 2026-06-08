//
//  MediaRule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct MediaRule: CSSRenderable {
    
    public let condition: MediaCondition
    public let rules: [any CSSRenderable]
    
    public init(
        _ condition: MediaCondition,
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.condition = condition
        self.rules = rules()
    }
    
    public func render(using renderer: CSSRenderer) {
        renderer.write("@media ")
        renderer.write(condition.rawValue(prettyPrinted: renderer.prettyPrinted))
        renderer.write(" {")
        
        if rules.isEmpty {
            renderer.write("}")
            return
        }
        
        if renderer.prettyPrinted {
            renderer.increaseIndentation()
            
            for (index, rule) in rules.enumerated() {
                renderer.writeLineBreak()
                
                if index > 0 {
                    renderer.writeLineBreak()
                }
                
                renderer.writeIndentation()
                rule.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
            renderer.write("}")
        } else {
            for rule in rules {
                rule.render(using: renderer)
            }
            
            renderer.write("}")
        }
    }
}

public struct MediaCondition: Sendable {
    
    private let query: Query
    
    private init(_ query: Query) {
        self.query = query
    }
}

public extension MediaCondition {
    
    static func maxWidth(_ value: CSSLength) -> Self {
        .init(.feature("max-width", value.rawValue))
    }
    
    static func minWidth(_ value: CSSLength) -> Self {
        .init(.feature("min-width", value.rawValue))
    }
    
    static func raw(_ value: String) -> Self {
        .init(.raw(value))
    }
}

private extension MediaCondition {
    
    enum Query: Sendable {
        
        case feature(String, String)
        case raw(String)
    }
    
    func rawValue(prettyPrinted: Bool) -> String {
        switch query {
        case let .feature(name, value):
            let separator = prettyPrinted ? ": " : ":"
            
            return "(\(name)\(separator)\(value))"
        case let .raw(value):
            return value
        }
    }
}
