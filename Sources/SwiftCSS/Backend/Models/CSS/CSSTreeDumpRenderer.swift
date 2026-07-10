//
//  CSSTreeDumpRenderer.swift
//  swift-css
//

public struct CSSTreeDumpRenderer: CSSRendererProtocol {

    public init() {}

    public func render(_ node: CSSNode) -> String {
        TreeDumpEngine().render(node)
    }

    public func render<Node: CSSNodeConvertible>(_ node: Node) -> String {
        render(node.cssNode)
    }
}

private final class TreeDumpEngine {

    private var lines: [String] = []

    func render(_ node: CSSNode) -> String {
        switch node {
        case let .stylesheet(stylesheet):
            lines.append("Stylesheet")
            appendChildren(stylesheet.children, prefix: "")
        case let .rule(rule):
            lines.append("Rule")
            appendRuleChildren(rule, prefix: "")
        case .media, .supports, .layer, .layerOrder, .keyframes, .keyframe, .declaration:
            append(node, prefix: "", isLast: true)
        }

        return lines.joined(separator: "\n")
    }

    private func appendChildren(_ children: [CSSNode], prefix: String) {
        for (index, child) in children.enumerated() {
            append(child, prefix: prefix, isLast: index == children.count - 1)
        }
    }

    private func append(_ node: CSSNode, prefix: String, isLast: Bool) {
        let nestedPrefix = childPrefix(prefix: prefix, isLast: isLast)

        switch node {
        case let .stylesheet(stylesheet):
            appendBranch("Stylesheet", prefix: prefix, isLast: isLast)
            appendChildren(stylesheet.children, prefix: nestedPrefix)
        case let .rule(rule):
            appendBranch("Rule", prefix: prefix, isLast: isLast)
            appendRuleChildren(rule, prefix: nestedPrefix)
        case let .media(media):
            appendBranch("@media \(render(media.condition))", prefix: prefix, isLast: isLast)
            appendChildren(media.children, prefix: nestedPrefix)
        case let .supports(supports):
            appendBranch("@supports \(render(supports.condition))", prefix: prefix, isLast: isLast)
            appendChildren(supports.children, prefix: nestedPrefix)
        case let .layer(layer):
            appendBranch(layer.name.map { "@layer \($0)" } ?? "@layer", prefix: prefix, isLast: isLast)
            appendChildren(layer.children, prefix: nestedPrefix)
        case let .layerOrder(order):
            appendBranch("@layer \(order.names.joined(separator: ", "));", prefix: prefix, isLast: isLast)
        case let .keyframes(keyframes):
            appendBranch("@keyframes \(keyframes.name)", prefix: prefix, isLast: isLast)
            appendChildren(keyframes.frames, prefix: nestedPrefix)
        case let .keyframe(keyframe):
            appendBranch("Keyframe \(render(keyframe.selector))", prefix: prefix, isLast: isLast)
            appendDeclarations(keyframe.declarations, prefix: nestedPrefix)
        case let .declaration(declaration):
            appendBranch(render(declaration), prefix: prefix, isLast: isLast)
        }
    }

    private func appendRuleChildren(_ rule: CSSRuleNode, prefix: String) {
        let selectorPrefix = prefix + (rule.declarations.isEmpty ? "└─ " : "├─ ")
        lines.append("\(selectorPrefix)selector: \(render(rule.selector))")
        appendDeclarations(rule.declarations, prefix: prefix)
    }

    private func appendDeclarations(_ declarations: [CSSDeclaration], prefix: String) {
        for (index, declaration) in declarations.enumerated() {
            appendBranch(
                render(declaration),
                prefix: prefix,
                isLast: index == declarations.count - 1
            )
        }
    }

    private func appendBranch(_ text: String, prefix: String, isLast: Bool) {
        lines.append("\(prefix)\(isLast ? "└─ " : "├─ ")\(text)")
    }

    private func childPrefix(prefix: String, isLast: Bool) -> String {
        prefix + (isLast ? "   " : "│  ")
    }

    private func render(_ declaration: CSSDeclaration) -> String {
        switch declaration {
        case let .property(node):
            "\(node.property): \(node.value)"
        case let .raw(node):
            "\(node.property): \(node.value)"
        }
    }

    private func render(_ condition: CSSConditionNode) -> String {
        switch condition {
        case let .feature(name, value):
            "(\(name): \(value))"
        case let .raw(value):
            value
        }
    }

    private func render(_ selector: CSSKeyframeSelectorNode) -> String {
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

    private func render(_ selector: CSSSelectorNode) -> String {
        selector.selectors.map { render($0) }.joined(separator: ", ")
    }

    private func render(_ selector: CSSComplexSelectorNode) -> String {
        ([render(selector.head)] + selector.tail.map { render($0) }).joined()
    }

    private func render(_ selector: CSSCompoundSelectorNode) -> String {
        selector.selectors.map { render($0) }.joined()
    }

    private func render(_ step: CSSSelectorCombinatorNode) -> String {
        "\(render(step.combinator))\(render(step.selector))"
    }

    private func render(_ combinator: CSSSelectorCombinator) -> String {
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

    private func render(_ selector: CSSSimpleSelectorNode) -> String {
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
