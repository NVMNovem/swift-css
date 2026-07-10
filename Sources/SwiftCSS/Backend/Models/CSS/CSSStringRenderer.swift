//
//  CSSStringRenderer.swift
//  swift-css
//

public struct CSSStringRenderer: CSSRendererProtocol {

    public let options: CSSRenderOptions

    public init(options: CSSRenderOptions = .init()) {
        self.options = options
    }

    public func render(_ node: CSSNode) -> String {
        Engine(options: options).render(node)
    }

    public func render<Node: CSSNodeConvertible>(_ node: Node) -> String {
        render(node.cssNode)
    }
}

private final class Engine {

    private var output = ""
    private var indentationLevel = 0
    private let options: CSSRenderOptions

    init(options: CSSRenderOptions) {
        self.options = options
    }

    func render(_ node: CSSNode) -> String {
        renderNode(node)
        return output
    }

    private func renderNode(_ node: CSSNode) {
        switch node {
        case let .stylesheet(stylesheet):
            renderChildren(stylesheet.children, separated: true)
        case let .rule(rule):
            renderDeclarationBlock(
                header: render(rule.selector),
                declarations: rule.declarations
            )
        case let .media(media):
            renderBlock(
                header: "@media \(render(media.condition))",
                children: media.children
            )
        case let .supports(supports):
            renderBlock(
                header: "@supports \(render(supports.condition))",
                children: supports.children
            )
        case let .layer(layer):
            renderBlock(
                header: layer.name.map { "@layer \($0)" } ?? "@layer",
                children: layer.children
            )
        case let .layerOrder(order):
            write("@layer ")
            write(order.names.joined(separator: ", "))
            write(";")
        case let .keyframes(keyframes):
            renderBlock(
                header: "@keyframes \(keyframes.name)",
                children: keyframes.frames
            )
        case let .keyframe(keyframe):
            renderDeclarationBlock(
                header: render(keyframe.selector),
                declarations: keyframe.declarations
            )
        case let .declaration(declaration):
            renderDeclaration(declaration)
        }
    }

    private func renderChildren(_ children: [CSSNode], separated: Bool) {
        for (index, child) in children.enumerated() {
            if separated && index > 0 {
                writeLineBreak()
                writeLineBreak()
            }

            renderNode(child)
        }
    }

    private func renderBlock(header: String, children: [CSSNode]) {
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
                renderNode(child)
            }

            indentationLevel -= 1
            writeLineBreak()
            writeIndentation()
        } else {
            renderChildren(children, separated: false)
        }

        write("}")
    }

    private func renderDeclarationBlock(
        header: String,
        declarations: [CSSDeclaration]
    ) {
        write(header)
        write(" {")

        guard !declarations.isEmpty else {
            write("}")
            return
        }

        if options.prettyPrinted {
            indentationLevel += 1

            for declaration in declarations {
                writeLineBreak()
                writeIndentation()
                renderDeclaration(declaration)
            }

            indentationLevel -= 1
            writeLineBreak()
            writeIndentation()
        } else {
            for declaration in declarations {
                renderDeclaration(declaration)
            }
        }

        write("}")
    }

    private func renderDeclaration(_ declaration: CSSDeclaration) {
        switch declaration {
        case let .property(node):
            renderDeclaration(property: node.property, value: node.value)
        case let .raw(node):
            renderDeclaration(property: node.property, value: node.value)
        }
    }

    private func renderDeclaration(property: String, value: String) {
        write(property)
        write(options.prettyPrinted ? ": " : ":")
        write(value)
        write(";")
    }

    private func render(_ condition: CSSConditionNode) -> String {
        switch condition {
        case let .feature(name, value):
            let separator = options.prettyPrinted ? ": " : ":"
            return "(\(name)\(separator)\(value))"
        case let .raw(value):
            return value
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

    private func write(_ string: String) {
        output += string
    }

    private func writeLineBreak() {
        if options.prettyPrinted {
            write("\n")
        }
    }

    private func writeIndentation() {
        if options.prettyPrinted {
            write(String(repeating: options.indentation, count: indentationLevel))
        }
    }
}
