//
//  MediaCondition.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

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
    
    static func prefersColorScheme(_ value: CSSColorSchemePreference) -> Self {
        .init(.feature("prefers-color-scheme", value.rawValue))
    }
    
    static func reducedMotion(_ value: CSSReducedMotionPreference) -> Self {
        .init(.feature("prefers-reduced-motion", value.rawValue))
    }
    
    static func raw(_ value: String) -> Self {
        .init(.raw(value))
    }
}

internal extension MediaCondition {
    
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
