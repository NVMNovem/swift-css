# SwiftCSS Architecture

SwiftCSS is a CSS AST/model package. It owns CSS values, properties,
declarations, rules, at-rules, and stylesheets as Swift data. Renderers own
output formats.

## Model Boundary

Model/data types:

- `CSSValue`, `Length`, `Percentage`, `Color`, `Time`, `Angle`, and keyword
  value types store CSS value data.
- `CSSProperty` and concrete property wrappers such as `Width`, `Color`,
  `GridTemplateColumns`, `TextTransform`, `Overflow`, and `RawProperty` store a
  property name and value.
- `SelectorPart`, `Selector`, `Rule`, `StyleSheet`, `MediaRule`, `Supports`,
  `Layer`, `LayerOrder`, `Keyframes`, and `Keyframe` store stylesheet
  structure.
- `CSSBuilder` and `CSSPropertyBuilder` collect model nodes; they do not render
  output.

## Renderer Boundary

`CSSRendererProtocol` defines renderer entry points for stylesheets and rules:

```swift
public protocol CSSRendererProtocol {
    associatedtype Output

    func render(_ stylesheet: StyleSheet) -> Output
    func render(_ rule: Rule) -> Output
}
```

`CSSStringRenderer` renders CSS text. It owns selector output, declaration
output, property/value formatting, at-rule output, indentation, pretty
printing, raw properties, and nested rule/at-rule output.

`CSSTreeDumpRenderer` renders a stable debug tree from the same model. It is a
small proof that the model can be traversed by non-CSS-text renderers.

Convenience APIs such as `stylesheet.render()` and `rule.render()` remain thin
wrappers around `CSSStringRenderer`.

Future renderers, such as a `CSSOMRenderer` or richer debug renderer, should
walk the existing `StyleSheet`, `Rule`, property, selector, and at-rule model
instead of adding output logic to those model types.

## Audit Notes

Before the renderer split, these types were model/data and also knew how to
render CSS text:

- `CSSProperty` implemented declaration rendering in a protocol extension.
- `StyleSheet`, `Rule`, `MediaRule`, `Supports`, `Layer`, `LayerOrder`,
  `Keyframes`, and `Keyframe` implemented `render(using:)`.
- `CSSBlockRenderer`, `CSSRenderContext`, `CSSOutputStream`,
  `CSSStringOutputStream`, and `CSSRenderer` were string-output support types.
- `MediaCondition` and `SupportsCondition` chose pretty/compact colon spacing.

String output was coupled into the model through `CSSRenderable.render(using:)`,
per-type `render(using:)` implementations, selector `rawValue` helpers,
condition `rawValue(prettyPrinted:)` helpers, and property declaration rendering
on `CSSProperty`.

That responsibility now lives in `CSSStringRenderer`. The remaining `rawValue`
properties on values and some internal selector helpers represent stored CSS
fragments or model-friendly value serialization, not block layout or output
format decisions.
