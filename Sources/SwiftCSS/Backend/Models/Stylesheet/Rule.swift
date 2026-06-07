//
//  Rule.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Rule: CSSRenderable {
    
    public let selector: Selector
    public let declarations: [Declaration]
    
    public init(
        _ selector: Selector,
        @DeclarationBuilder declarations: () -> [Declaration]
    ) {
        self.selector = selector
        self.declarations = declarations()
    }
    
    public func render(using renderer: CSSRenderer) {
        renderer.write(selector.rawValue)
        renderer.write(" {")
        
        if declarations.isEmpty {
            renderer.write("}")
            return
        }
        
        if renderer.prettyPrinted {
            renderer.increaseIndentation()
            
            for declaration in declarations {
                renderer.writeLineBreak()
                renderer.writeIndentation()
                declaration.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
            renderer.write("}")
        } else {
            for declaration in declarations {
                declaration.render(using: renderer)
            }
            
            renderer.write("}")
        }
    }
}
