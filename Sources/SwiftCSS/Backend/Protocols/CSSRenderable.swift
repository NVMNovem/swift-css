//
//  CSSRenderable.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSRenderable {
    
    func render(using renderer: CSSRenderer)
}

public extension CSSRenderable {
    
    func render(
        options: CSSRenderOptions = .init()
    ) -> String {
        CSSRenderer(options: options).render(self)
    }
    
    func render(prettyPrinted: Bool) -> String {
        render(
            options: CSSRenderOptions(
                prettyPrinted: prettyPrinted
            )
        )
    }
}
