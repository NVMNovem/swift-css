//
//  DeclarationBuilder.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

@resultBuilder
public enum DeclarationBuilder {
    
    public static func buildBlock(_ components: Declaration...) -> [Declaration] {
        components
    }
    
    public static func buildArray(_ components: [[Declaration]]) -> [Declaration] {
        components.flatMap(\.self)
    }
    
    public static func buildOptional(_ component: [Declaration]?) -> [Declaration] {
        component ?? []
    }
    
    public static func buildEither(first component: [Declaration]) -> [Declaration] {
        component
    }
    
    public static func buildEither(second component: [Declaration]) -> [Declaration] {
        component
    }
}
