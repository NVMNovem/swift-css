//
//  Selector.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct SelectorPart: Sendable {
    
    let fragment: SelectorFragment
    
    init(_ fragment: SelectorFragment) {
        self.fragment = fragment
    }
}

public extension SelectorPart {
    
    static func `class`(_ value: String) -> Self {
        .init(.simple(.class(value)))
    }
    
    static func id(_ value: String) -> Self {
        .init(.simple(.id(value)))
    }
    
    static func element(_ value: String) -> Self {
        .init(.simple(.element(value)))
    }
    
    static func raw(_ value: String) -> Self {
        .init(.simple(.raw(value)))
    }
    
    static var root: Self {
        .init(.simple(.pseudoClass("root")))
    }
    
    static var universal: Self {
        .init(.simple(.universal))
    }
    
    static var hover: Self {
        .init(.simple(.pseudoClass("hover")))
    }
    
    static var focus: Self {
        .init(.simple(.pseudoClass("focus")))
    }
    
    static var active: Self {
        .init(.simple(.pseudoClass("active")))
    }
    
    static var before: Self {
        .init(.simple(.pseudoElement("before")))
    }
    
    static var after: Self {
        .init(.simple(.pseudoElement("after")))
    }
    
    static func descendant(_ parts: SelectorPart...) -> Self {
        .init(.combinator(.descendant, parts))
    }
    
    static func child(_ parts: SelectorPart...) -> Self {
        .init(.combinator(.child, parts))
    }
    
    static func adjacentSibling(_ parts: SelectorPart...) -> Self {
        .init(.combinator(.adjacentSibling, parts))
    }
    
    static func generalSibling(_ parts: SelectorPart...) -> Self {
        .init(.combinator(.generalSibling, parts))
    }
}

internal struct Selector: Sendable {
    
    let selectors: [ComplexSelector]
    
    init(_ parts: [SelectorPart]) {
        self.selectors = [
            ComplexSelector(parts)
        ]
    }
    
    init(list: [[SelectorPart]]) {
        self.selectors = list.map(ComplexSelector.init)
    }

    var cssNode: CSSSelectorNode {
        .init(selectors: selectors.map { $0.cssNode })
    }
}

internal enum SelectorFragment: Sendable {
    
    case simple(SimpleSelector)
    case combinator(SelectorCombinator, [SelectorPart])
}

internal enum SimpleSelector: Sendable {
    
    case `class`(String)
    case id(String)
    case element(String)
    case universal
    case pseudoClass(String)
    case pseudoElement(String)
    case raw(String)
}

internal struct CompoundSelector: Sendable {
    
    let simpleSelectors: [SimpleSelector]
    
    init(_ simpleSelectors: [SimpleSelector]) {
        self.simpleSelectors = simpleSelectors
    }
}

internal struct ComplexSelector: Sendable {
    
    let compoundSelector: CompoundSelector
    let combinators: [SelectorCombinatorStep]
    
    init(_ parts: [SelectorPart]) {
        var builder = ComplexSelectorBuilder()
        
        for part in parts {
            builder.append(part)
        }
        
        self = builder.build()
    }
}

internal struct SelectorCombinatorStep: Sendable {
    
    let combinator: SelectorCombinator
    let selector: CompoundSelector
}

internal enum SelectorCombinator: Sendable {
    
    case descendant
    case child
    case adjacentSibling
    case generalSibling
}

private struct ComplexSelectorBuilder {
    
    private var simpleSelectors: [SimpleSelector] = []
    private var compoundSelector: CompoundSelector?
    private var combinators: [SelectorCombinatorStep] = []
    
    mutating func append(_ part: SelectorPart) {
        switch part.fragment {
        case let .simple(simpleSelector):
            simpleSelectors.append(simpleSelector)
        case let .combinator(combinator, parts):
            let selector = ComplexSelector(parts)
            
            flushCurrentCompoundSelector()
            combinators.append(
                SelectorCombinatorStep(
                    combinator: combinator,
                    selector: selector.compoundSelector
                )
            )
            combinators.append(contentsOf: selector.combinators)
        }
    }
    
    mutating func build() -> ComplexSelector {
        flushCurrentCompoundSelector()
        
        return ComplexSelector(
            compoundSelector: compoundSelector ?? CompoundSelector([]),
            combinators: combinators
        )
    }
    
    private mutating func flushCurrentCompoundSelector() {
        guard !simpleSelectors.isEmpty else {
            return
        }
        
        let selector = CompoundSelector(simpleSelectors)
        
        if compoundSelector == nil {
            compoundSelector = selector
        } else {
            combinators.append(
                SelectorCombinatorStep(
                    combinator: .descendant,
                    selector: selector
                )
            )
        }
        
        simpleSelectors.removeAll()
    }
}

private extension ComplexSelector {

    var cssNode: CSSComplexSelectorNode {
        .init(
            head: compoundSelector.cssNode,
            tail: combinators.map { $0.cssNode }
        )
    }
    
    init(
        compoundSelector: CompoundSelector,
        combinators: [SelectorCombinatorStep]
    ) {
        self.compoundSelector = compoundSelector
        self.combinators = combinators
    }
}

private extension CompoundSelector {
    var cssNode: CSSCompoundSelectorNode {
        .init(selectors: simpleSelectors.map { $0.cssNode })
    }
}

private extension SelectorCombinatorStep {
    var cssNode: CSSSelectorCombinatorNode {
        .init(combinator: combinator.cssNode, selector: selector.cssNode)
    }
}

private extension SelectorCombinator {
    var cssNode: CSSSelectorCombinator {
        switch self {
        case .descendant:
            .descendant
        case .child:
            .child
        case .adjacentSibling:
            .adjacentSibling
        case .generalSibling:
            .generalSibling
        }
    }
}

private extension SimpleSelector {
    var cssNode: CSSSimpleSelectorNode {
        switch self {
        case let .class(value):
            .class(value)
        case let .id(value):
            .id(value)
        case let .element(value):
            .element(value)
        case .universal:
            .universal
        case let .pseudoClass(value):
            .pseudoClass(value)
        case let .pseudoElement(value):
            .pseudoElement(value)
        case let .raw(value):
            .raw(value)
        }
    }
}
