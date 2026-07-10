//
//  CSSNode.swift
//  swift-css
//

/// The concrete renderer model produced by SwiftCSS's public typed DSL.
public indirect enum CSSNode: Sendable {
    case stylesheet(CSSStylesheetNode)
    case rule(CSSRuleNode)
    case media(CSSConditionalRuleNode)
    case supports(CSSConditionalRuleNode)
    case layer(CSSLayerNode)
    case layerOrder(CSSLayerOrderNode)
    case keyframes(CSSKeyframesNode)
    case keyframe(CSSKeyframeNode)
    case declaration(CSSDeclaration)
}

public struct CSSStylesheetNode: Sendable {
    public let children: [CSSNode]

    public init(children: [CSSNode]) {
        self.children = children
    }
}

public struct CSSRuleNode: Sendable {
    public let selector: CSSSelectorNode
    public let declarations: [CSSDeclaration]

    public init(selector: CSSSelectorNode, declarations: [CSSDeclaration]) {
        self.selector = selector
        self.declarations = declarations
    }
}

public struct CSSConditionalRuleNode: Sendable {
    public let condition: CSSConditionNode
    public let children: [CSSNode]

    public init(condition: CSSConditionNode, children: [CSSNode]) {
        self.condition = condition
        self.children = children
    }
}

public struct CSSLayerNode: Sendable {
    public let name: String?
    public let children: [CSSNode]

    public init(name: String?, children: [CSSNode]) {
        self.name = name
        self.children = children
    }
}

public struct CSSLayerOrderNode: Sendable {
    public let names: [String]

    public init(names: [String]) {
        self.names = names
    }
}

public struct CSSKeyframesNode: Sendable {
    public let name: String
    public let frames: [CSSNode]

    public init(name: String, frames: [CSSNode]) {
        self.name = name
        self.frames = frames
    }
}

public struct CSSKeyframeNode: Sendable {
    public let selector: CSSKeyframeSelectorNode
    public let declarations: [CSSDeclaration]

    public init(selector: CSSKeyframeSelectorNode, declarations: [CSSDeclaration]) {
        self.selector = selector
        self.declarations = declarations
    }
}

public enum CSSDeclaration: Sendable {
    case property(CSSDeclarationNode)
    case raw(CSSRawDeclarationNode)
}

public struct CSSDeclarationNode: Sendable {
    public let property: String
    public let value: String

    public init(property: String, value: String) {
        self.property = property
        self.value = value
    }
}

public struct CSSRawDeclarationNode: Sendable {
    public let property: String
    public let value: String

    public init(property: String, value: String) {
        self.property = property
        self.value = value
    }
}

public enum CSSConditionNode: Sendable {
    case feature(name: String, value: String)
    case raw(String)
}

public struct CSSSelectorNode: Sendable {
    public let selectors: [CSSComplexSelectorNode]

    public init(selectors: [CSSComplexSelectorNode]) {
        self.selectors = selectors
    }
}

public struct CSSComplexSelectorNode: Sendable {
    public let head: CSSCompoundSelectorNode
    public let tail: [CSSSelectorCombinatorNode]

    public init(head: CSSCompoundSelectorNode, tail: [CSSSelectorCombinatorNode]) {
        self.head = head
        self.tail = tail
    }
}

public struct CSSCompoundSelectorNode: Sendable {
    public let selectors: [CSSSimpleSelectorNode]

    public init(selectors: [CSSSimpleSelectorNode]) {
        self.selectors = selectors
    }
}

public struct CSSSelectorCombinatorNode: Sendable {
    public let combinator: CSSSelectorCombinator
    public let selector: CSSCompoundSelectorNode

    public init(combinator: CSSSelectorCombinator, selector: CSSCompoundSelectorNode) {
        self.combinator = combinator
        self.selector = selector
    }
}

public enum CSSSelectorCombinator: Sendable {
    case descendant
    case child
    case adjacentSibling
    case generalSibling
}

public enum CSSSimpleSelectorNode: Sendable {
    case `class`(String)
    case id(String)
    case element(String)
    case universal
    case pseudoClass(String)
    case pseudoElement(String)
    case raw(String)
}

public enum CSSKeyframeSelectorNode: Sendable {
    case from
    case to
    case percent(Int)
    case raw(String)
}
