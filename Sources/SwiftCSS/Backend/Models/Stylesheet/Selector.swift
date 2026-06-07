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
    
    var rawValue: String {
        selectors
            .map(\.rawValue)
            .joined(separator: ", ")
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
    
    var rawValue: String {
        switch self {
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

internal struct CompoundSelector: Sendable {
    
    let simpleSelectors: [SimpleSelector]
    
    init(_ simpleSelectors: [SimpleSelector]) {
        self.simpleSelectors = simpleSelectors
    }
    
    var rawValue: String {
        simpleSelectors
            .map(\.rawValue)
            .joined()
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
    
    var rawValue: String {
        (
            [compoundSelector.rawValue] +
            combinators.map(\.rawValue)
        )
        .joined()
    }
}

internal struct SelectorCombinatorStep: Sendable {
    
    let combinator: SelectorCombinator
    let selector: CompoundSelector
    
    var rawValue: String {
        "\(combinator.rawValue)\(selector.rawValue)"
    }
}

internal enum SelectorCombinator: Sendable {
    
    case descendant
    case child
    case adjacentSibling
    case generalSibling
    
    var rawValue: String {
        switch self {
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
    
    init(
        compoundSelector: CompoundSelector,
        combinators: [SelectorCombinatorStep]
    ) {
        self.compoundSelector = compoundSelector
        self.combinators = combinators
    }
}
