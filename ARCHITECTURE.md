# SwiftCSS Architecture

SwiftCSS has two distinct layers:

```text
Public SwiftCSS DSL
        ↓
Concrete CSS AST
        ↓
CSSStringRenderer
CSSTreeDumpRenderer
Future CSSOMRenderer
```

## 1. Public Typed DSL

The public authoring layer keeps readable Swift types such as `StyleSheet`,
`Rule`, `Width`, `Color`, `Display`, `Padding`, selectors, media conditions,
supports rules, layers, and keyframes. Typed value wrappers such as `Length`,
`Percentage`, `Time`, and `Angle` retain explicit initializers and helpers.
Property-specific wrappers such as `LineHeightValue` represent CSS grammars
that do not fit a reusable type: unitless line-height multipliers, for example,
are intentionally not modeled as `Length`.

Property structs conform to `CSSProperty`, whose default lowering produces a
concrete `CSSDeclaration`. `RawProperty` explicitly lowers to the raw
declaration case. Stylesheet-level DSL types conform to `CSSNodeConvertible`
and expose their lowered `cssNode`.

`CSSBuilder` and `CSSPropertyBuilder` lower each generic DSL expression as it
enters a result builder. Their stored and returned arrays contain only
`CSSNode` or `CSSDeclaration`; optionals, conditionals, loops, and arrays are
flattened without protocol existential storage.

## 2. Concrete Renderer Model

`CSSNode` is the recursive renderer input. Its exhaustive cases cover:

- stylesheets and qualified rules;
- media and supports blocks;
- named and anonymous layers plus layer ordering;
- keyframes and individual keyframe blocks;
- standalone declarations.

Supporting concrete values include `CSSStylesheetNode`, `CSSRuleNode`,
`CSSConditionalRuleNode`, `CSSLayerNode`, `CSSKeyframesNode`,
`CSSDeclaration`, `CSSConditionNode`, and the concrete selector model rooted at
`CSSSelectorNode`.

Selectors remain ergonomic in the public DSL through `SelectorPart.class`,
`.id`, `.element`, pseudo selectors, and combinators. Lowering converts them to
concrete simple, compound, complex, and combinator nodes. Renderers never
inspect public selector types dynamically.

## Renderer Boundary

`CSSRendererProtocol` accepts one concrete input:

```swift
public protocol CSSRendererProtocol {
    associatedtype Output

    func render(_ node: CSSNode) -> Output
}
```

`CSSStringRenderer` owns CSS syntax, selector formatting, condition formatting,
declarations, braces, nested at-rules, keyframes, indentation, and pretty or
compact output. `CSSTreeDumpRenderer` walks the same AST to produce stable debug
output. Both use exhaustive switches over concrete enums.

Conveniences such as `stylesheet.render()` and `rule.render()` are thin
wrappers: they obtain `cssNode` and pass it to `CSSStringRenderer`. Renderer
generic conveniences do the same before entering the concrete rendering
engine.

## Why This Boundary Exists

The two-layer design:

- avoids protocol existential storage and traversal;
- avoids dynamic casts and reflection-based discovery;
- supports Embedded Swift restrictions;
- preserves typed, capitalized CSS authoring APIs;
- lets string, debug, and future CSSOM renderers share one stable model.

New DSL types should lower at construction time. New renderer features should
be represented by a concrete AST case and handled exhaustively by every
renderer rather than discovered from the public type at runtime.
