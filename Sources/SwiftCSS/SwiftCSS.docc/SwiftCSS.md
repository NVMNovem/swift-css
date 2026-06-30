# SwiftCSS

Build CSS stylesheets with a Swift result-builder DSL.

## Overview

SwiftCSS models CSS as small renderable Swift values. Use ``StyleSheet`` as the
root, add qualified rules with ``Rule``, choose typed property wrappers such as
``Display`` and ``Padding``, and render the result to formatted or compact CSS.

```swift
import SwiftCSS

let stylesheet = StyleSheet {
    Rule(.class("card")) {
        Display(.flex)
        Position(.relative)
        Width(.percent(100))
        Height(.auto)
        BackgroundColor(.css("var(--panel)"))
        BorderColor(.clear)
        Padding(.px(24))
        FontWeight(.weight(700))
    }

    Media(.maxWidth(.px(760))) {
        Rule(.class("card")) {
            Display(.block)
        }
    }
}

let css = stylesheet.render()
```

SwiftCSS keeps first-class declarations intentionally simple: each property
stores a CSS property name and rendered value, while reusable value wrappers
provide typed construction for common CSS units and keywords. Use ``RawProperty``
when the package does not yet expose a dedicated property wrapper.

## Topics

### Getting Started

- <doc:Building-Stylesheets>
- <doc:CSS-Properties>
- <doc:Rendering-CSS>
- <doc:Previewing-DocC>

### Stylesheets and Rules

- ``StyleSheet``
- ``Rule``
- ``SelectorPart``
- ``CSSBuilder``
- ``CSSPropertyBuilder``

### At-Rules

- ``Media``
- ``MediaRule``
- ``MediaCondition``
- ``Supports``
- ``SupportsCondition``
- ``Layer``
- ``LayerOrder``
- ``Keyframes``
- ``Keyframe``
- ``KeyframeSelector``

### CSS Properties

- ``CSSProperty``
- ``RawProperty``
- ``AlignItems``
- ``BackdropFilter``
- ``BackgroundColor``
- ``Border``
- ``BorderColor``
- ``BorderRadius``
- ``BorderStyle``
- ``BorderWidth``
- ``Bottom``
- ``BoxShadow``
- ``BoxSizing``
- ``Color``
- ``ColumnGap``
- ``Display``
- ``FlexWrap``
- ``FontFamily``
- ``FontSize``
- ``FontWeight``
- ``Gap``
- ``GridTemplateColumns``
- ``GridTemplateRows``
- ``Height``
- ``Inset``
- ``JustifyContent``
- ``Left``
- ``LetterSpacing``
- ``LineHeight``
- ``Margin``
- ``MaxHeight``
- ``MaxWidth``
- ``MinHeight``
- ``MinWidth``
- ``Opacity``
- ``Padding``
- ``Position``
- ``Right``
- ``RowGap``
- ``TextAlign``
- ``TextDecoration``
- ``TextTransform``
- ``Top``
- ``Transform``
- ``Transition``
- ``TransitionDuration``
- ``Width``
- ``ZIndex``

### CSS Values

- ``CSSValue``
- ``Length``
- ``Percentage``
- ``Color``
- ``Time``
- ``Angle``
- ``AlignItemsValue``
- ``BoxSizingValue``
- ``DisplayValue``
- ``FlexWrapValue``
- ``JustifyContentValue``
- ``OverflowValue``
- ``PositionValue``
- ``TextAlignValue``
- ``TextDecorationValue``
- ``TextTransformValue``
- ``CSSColorSchemePreference``
- ``CSSReducedMotionPreference``

### Rendering

- ``CSSRenderable``
- ``CSSRenderer``
- ``CSSRenderOptions``
- ``CSSRenderContext``
- ``CSSOutputStream``
- ``CSSStringOutputStream``
