//
//  CSSStringRenderer.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 06/07/2026.
//

public struct CSSStringRenderer: CSSRendererProtocol {
    
    public let options: CSSRenderOptions
    
    public init(options: CSSRenderOptions = .init()) {
        self.options = options
    }
    
    public func render(_ stylesheet: StyleSheet) -> String {
        Engine(options: options).render(stylesheet)
    }
    
    public func render(_ rule: Rule) -> String {
        Engine(options: options).render(rule)
    }
    
    public func render(_ renderable: any CSSRenderable) -> String {
        Engine(options: options).render(renderable)
    }
    
    public func render(_ property: any CSSProperty) -> String {
        Engine(options: options).render(property)
    }
}

private final class Engine {
    
    private var output = ""
    private var indentationLevel = 0
    private let options: CSSRenderOptions
    
    init(options: CSSRenderOptions) {
        self.options = options
    }
    
    func render(_ stylesheet: StyleSheet) -> String {
        renderStylesheet(stylesheet)
        return output
    }
    
    func render(_ rule: Rule) -> String {
        renderRule(rule)
        return output
    }
    
    func render(_ renderable: any CSSRenderable) -> String {
        renderRenderable(renderable)
        return output
    }
    
    func render(_ property: any CSSProperty) -> String {
        renderProperty(property)
        return output
    }
    
    private func renderStylesheet(_ stylesheet: StyleSheet) {
        for (index, rule) in stylesheet.rules.enumerated() {
            if index > 0 {
                writeLineBreak()
                
                if options.prettyPrinted {
                    writeLineBreak()
                }
            }
            
            renderRenderable(rule)
        }
    }
    
    private func renderRenderable(_ renderable: any CSSRenderable) {
        switch renderable {
        case let stylesheet as StyleSheet:
            renderStylesheet(stylesheet)
        case let rule as Rule:
            renderRule(rule)
        case let mediaRule as MediaRule:
            renderBlock(
                header: "@media \(render(mediaRule.condition))",
                children: mediaRule.rules
            )
        case let supports as Supports:
            renderBlock(
                header: "@supports \(render(supports.condition))",
                children: supports.rules
            )
        case let layer as Layer:
            renderBlock(
                header: layer.name.map { "@layer \($0)" } ?? "@layer",
                children: layer.rules
            )
        case let layerOrder as LayerOrder:
            write("@layer ")
            write(layerOrder.names.joined(separator: ", "))
            write(";")
        case let keyframes as Keyframes:
            renderBlock(
                header: "@keyframes \(keyframes.name)",
                children: keyframes.frames
            )
        case let keyframe as Keyframe:
            renderPropertyBlock(
                header: render(keyframe.selector),
                properties: keyframe.properties
            )
        case let property as any CSSProperty:
            renderProperty(property)
        default:
            fatalError("Unsupported CSS renderable: \(type(of: renderable))")
        }
    }
    
    private func renderRule(_ rule: Rule) {
        renderPropertyBlock(
            header: render(rule.selector),
            properties: rule.properties
        )
    }
    
    private func renderBlock(
        header: String,
        children: [any CSSRenderable]
    ) {
        write(header)
        write(" {")
        
        guard !children.isEmpty else {
            write("}")
            return
        }
        
        if options.prettyPrinted {
            indentationLevel += 1
            
            for (index, child) in children.enumerated() {
                writeLineBreak()
                
                if index > 0 {
                    writeLineBreak()
                }
                
                writeIndentation()
                renderRenderable(child)
            }
            
            indentationLevel -= 1
            writeLineBreak()
            writeIndentation()
            write("}")
        } else {
            for child in children {
                renderRenderable(child)
            }
            
            write("}")
        }
    }
    
    private func renderPropertyBlock(
        header: String,
        properties: [any CSSProperty]
    ) {
        write(header)
        write(" {")
        
        guard !properties.isEmpty else {
            write("}")
            return
        }
        
        if options.prettyPrinted {
            indentationLevel += 1
            
            for property in properties {
                writeLineBreak()
                writeIndentation()
                renderProperty(property)
            }
            
            indentationLevel -= 1
            writeLineBreak()
            writeIndentation()
            write("}")
        } else {
            for property in properties {
                renderProperty(property)
            }
            
            write("}")
        }
    }
    
    private func renderProperty(_ property: any CSSProperty) {
        write(property.name)
        write(options.prettyPrinted ? ": " : ":")
        write(property.value)
        write(";")
    }
    
    private func render(_ condition: MediaCondition) -> String {
        switch condition.query {
        case let .feature(name, value):
            let separator = options.prettyPrinted ? ": " : ":"
            return "(\(name)\(separator)\(value))"
        case let .raw(value):
            return value
        }
    }
    
    private func render(_ condition: SupportsCondition) -> String {
        switch condition.query {
        case let .property(name, value):
            let separator = options.prettyPrinted ? ": " : ":"
            return "(\(name)\(separator)\(value))"
        case let .raw(value):
            return value
        }
    }
    
    private func render(_ selector: KeyframeSelector) -> String {
        switch selector {
        case .from:
            "from"
        case .to:
            "to"
        case let .percent(value):
            "\(value)%"
        case let .raw(value):
            value
        }
    }
    
    private func render(_ selector: Selector) -> String {
        selector.selectors
            .map(render)
            .joined(separator: ", ")
    }
    
    private func render(_ selector: ComplexSelector) -> String {
        (
            [render(selector.compoundSelector)] +
            selector.combinators.map(render)
        )
        .joined()
    }
    
    private func render(_ selector: CompoundSelector) -> String {
        selector.simpleSelectors
            .map(render)
            .joined()
    }
    
    private func render(_ step: SelectorCombinatorStep) -> String {
        "\(render(step.combinator))\(render(step.selector))"
    }
    
    private func render(_ combinator: SelectorCombinator) -> String {
        switch combinator {
        case .descendant:
            " "
        case .child:
            " > "
        case .adjacentSibling:
            " + "
        case .generalSibling:
            " ~ "
        }
    }
    
    private func render(_ selector: SimpleSelector) -> String {
        switch selector {
        case let .class(value):
            ".\(value)"
        case let .id(value):
            "#\(value)"
        case let .element(value):
            value
        case .universal:
            "*"
        case let .pseudoClass(value):
            ":\(value)"
        case let .pseudoElement(value):
            "::\(value)"
        case let .raw(value):
            value
        }
    }
    
    private func write(_ string: String) {
        output += string
    }
    
    private func writeLineBreak() {
        guard options.prettyPrinted else {
            return
        }
        
        write("\n")
    }
    
    private func writeIndentation() {
        guard options.prettyPrinted else {
            return
        }
        
        write(
            String(
                repeating: options.indentation,
                count: indentationLevel
            )
        )
    }
}
