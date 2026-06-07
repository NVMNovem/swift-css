//
//  CSSRenderOptions.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct CSSRenderOptions: Sendable {
    
    public var prettyPrinted: Bool
    public var indentation: String
    
    public init(
        prettyPrinted: Bool = true,
        indentation: String = "    "
    ) {
        self.prettyPrinted = prettyPrinted
        self.indentation = indentation
    }
}
