//
//  CSSRenderable.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public protocol CSSNodeConvertible {
    var cssNode: CSSNode { get }
}

public typealias CSSRenderable = CSSNodeConvertible

public extension CSSNodeConvertible {
    
    func render(
        options: CSSRenderOptions = .init()
    ) -> String {
        CSSStringRenderer(options: options).render(cssNode)
    }
    
    func render(prettyPrinted: Bool) -> String {
        render(
            options: CSSRenderOptions(
                prettyPrinted: prettyPrinted
            )
        )
    }
}
