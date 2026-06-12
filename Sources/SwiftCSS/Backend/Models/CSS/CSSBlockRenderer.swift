//
//  CSSBlockRenderer.swift
//  swift-css
//
//  Created by Codex on 12/06/2026.
//

internal enum CSSBlockRenderer {
    
    static func renderRenderableBlock(
        header: String,
        children: [any CSSRenderable],
        using renderer: CSSRenderer
    ) {
        renderer.write(header)
        renderer.write(" {")
        
        if children.isEmpty {
            renderer.write("}")
            return
        }
        
        if renderer.prettyPrinted {
            renderer.increaseIndentation()
            
            for (index, child) in children.enumerated() {
                renderer.writeLineBreak()
                
                if index > 0 {
                    renderer.writeLineBreak()
                }
                
                renderer.writeIndentation()
                child.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
            renderer.write("}")
        } else {
            for child in children {
                child.render(using: renderer)
            }
            
            renderer.write("}")
        }
    }
    
    static func renderPropertyBlock(
        header: String,
        properties: [any CSSProperty],
        using renderer: CSSRenderer
    ) {
        renderer.write(header)
        renderer.write(" {")
        
        if properties.isEmpty {
            renderer.write("}")
            return
        }
        
        if renderer.prettyPrinted {
            renderer.increaseIndentation()
            
            for property in properties {
                renderer.writeLineBreak()
                renderer.writeIndentation()
                property.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
            renderer.write("}")
        } else {
            for property in properties {
                property.render(using: renderer)
            }
            
            renderer.write("}")
        }
    }
}
