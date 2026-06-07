//
//  CSSRenderer.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public final class CSSRenderer {
    
    private let stream: CSSOutputStream
    private var context: CSSRenderContext
    
    public init(
        stream: CSSOutputStream,
        options: CSSRenderOptions = .init()
    ) {
        self.stream = stream
        self.context = CSSRenderContext(options: options)
    }
    
    public convenience init(
        options: CSSRenderOptions = .init()
    ) {
        self.init(
            stream: CSSStringOutputStream(),
            options: options
        )
    }
    
    public func render(_ renderable: any CSSRenderable) -> String {
        let stream = CSSStringOutputStream()
        let renderer = CSSRenderer(
            stream: stream,
            options: context.options
        )
        
        renderable.render(using: renderer)
        
        return stream.output
    }
    
    public func write(_ string: String) {
        stream.write(string)
    }
    
    public func writeLineBreak() {
        guard context.options.prettyPrinted else {
            return
        }
        
        stream.write("\n")
    }
    
    public func writeIndentation() {
        guard context.options.prettyPrinted else {
            return
        }
        
        stream.write(
            String(
                repeating: context.options.indentation,
                count: context.indentationLevel
            )
        )
    }
    
    public func increaseIndentation() {
        context.indentationLevel += 1
    }
    
    public func decreaseIndentation() {
        context.indentationLevel -= 1
    }
    
    public var prettyPrinted: Bool {
        context.options.prettyPrinted
    }
}
