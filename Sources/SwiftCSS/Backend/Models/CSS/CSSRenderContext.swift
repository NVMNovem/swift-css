//
//  CSSRenderContext.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct CSSRenderContext: Sendable {
    
    public var options: CSSRenderOptions
    public var indentationLevel: Int
    
    public init(
        options: CSSRenderOptions = .init(),
        indentationLevel: Int = 0
    ) {
        self.options = options
        self.indentationLevel = indentationLevel
    }
}
