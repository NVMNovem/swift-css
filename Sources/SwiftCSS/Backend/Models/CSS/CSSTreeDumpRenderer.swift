//
//  CSSTreeDumpRenderer.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 06/07/2026.
//

public struct CSSTreeDumpRenderer: CSSRendererProtocol {
    
    public init() {}
    
    public func render(_ stylesheet: StyleSheet) -> String {
        TreeDumpEngine().render(stylesheet)
    }
    
    public func render(_ rule: Rule) -> String {
        TreeDumpEngine().render(rule)
    }
    
    public func render(_ renderable: any CSSRenderable) -> String {
        TreeDumpEngine().render(renderable)
    }
}

private final class TreeDumpEngine {
    
    private var lines: [String] = []
    
    func render(_ stylesheet: StyleSheet) -> String {
        lines.append("Stylesheet")
        appendChildren(stylesheet.rules, prefix: "")
        return lines.joined(separator: "\n")
    }
    
    func render(_ rule: Rule) -> String {
        lines.append("Rule")
        appendRuleChildren(rule, prefix: "")
        return lines.joined(separator: "\n")
    }
    
    func render(_ renderable: any CSSRenderable) -> String {
        append(renderable, prefix: "", isLast: true)
        return lines.joined(separator: "\n")
    }
    
    private func appendChildren(
        _ children: [any CSSRenderable],
        prefix: String
    ) {
        for (index, child) in children.enumerated() {
            append(
                child,
                prefix: prefix,
                isLast: index == children.count - 1
            )
        }
    }
    
    private func append(
        _ renderable: any CSSRenderable,
        prefix: String,
        isLast: Bool
    ) {
        switch renderable {
        case let stylesheet as StyleSheet:
            appendBranch("Stylesheet", prefix: prefix, isLast: isLast)
            appendChildren(
                stylesheet.rules,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let rule as Rule:
            appendBranch("Rule", prefix: prefix, isLast: isLast)
            appendRuleChildren(
                rule,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let mediaRule as MediaRule:
            appendBranch("@media \(render(mediaRule.condition))", prefix: prefix, isLast: isLast)
            appendChildren(
                mediaRule.rules,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let supports as Supports:
            appendBranch("@supports \(render(supports.condition))", prefix: prefix, isLast: isLast)
            appendChildren(
                supports.rules,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let layer as Layer:
            appendBranch(layer.name.map { "@layer \($0)" } ?? "@layer", prefix: prefix, isLast: isLast)
            appendChildren(
                layer.rules,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let layerOrder as LayerOrder:
            appendBranch("@layer \(layerOrder.names.joined(separator: ", "));", prefix: prefix, isLast: isLast)
        case let keyframes as Keyframes:
            appendBranch("@keyframes \(keyframes.name)", prefix: prefix, isLast: isLast)
            appendChildren(
                keyframes.frames,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let keyframe as Keyframe:
            appendBranch("Keyframe \(render(keyframe.selector))", prefix: prefix, isLast: isLast)
            appendProperties(
                keyframe.properties,
                prefix: childPrefix(prefix: prefix, isLast: isLast)
            )
        case let property as any CSSProperty:
            appendBranch("\(property.name): \(property.value)", prefix: prefix, isLast: isLast)
        default:
            appendBranch("Unsupported \(type(of: renderable))", prefix: prefix, isLast: isLast)
        }
    }
    
    private func appendRuleChildren(
        _ rule: Rule,
        prefix: String
    ) {
        let propertyPrefix = prefix + (rule.properties.isEmpty ? "└─ " : "├─ ")
        lines.append("\(propertyPrefix)selector: \(render(rule.selector))")
        appendProperties(rule.properties, prefix: prefix)
    }
    
    private func appendProperties(
        _ properties: [any CSSProperty],
        prefix: String
    ) {
        for (index, property) in properties.enumerated() {
            appendBranch(
                "\(property.name): \(property.value)",
                prefix: prefix,
                isLast: index == properties.count - 1
            )
        }
    }
    
    private func appendBranch(
        _ text: String,
        prefix: String,
        isLast: Bool
    ) {
        lines.append("\(prefix)\(isLast ? "└─ " : "├─ ")\(text)")
    }
    
    private func childPrefix(
        prefix: String,
        isLast: Bool
    ) -> String {
        prefix + (isLast ? "   " : "│  ")
    }
    
    private func render(_ condition: MediaCondition) -> String {
        switch condition.query {
        case let .feature(name, value):
            return "(\(name): \(value))"
        case let .raw(value):
            return value
        }
    }
    
    private func render(_ condition: SupportsCondition) -> String {
        switch condition.query {
        case let .property(name, value):
            return "(\(name): \(value))"
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
}
