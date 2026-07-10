# SwiftCSS

Build CSS stylesheets with a Swift result-builder DSL.

## Overview

SwiftCSS models CSS as Swift data. Use ``StyleSheet`` as the root, add
qualified rules with ``Rule``, choose typed property wrappers such as
``Display`` and ``Padding``, and pass the model to a renderer for formatted CSS,
compact CSS, or debug output.

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
stores a CSS property name and value, while reusable value wrappers provide
typed construction for common CSS units and keywords. ``CSSStringRenderer`` owns
CSS text output. Use ``RawProperty`` when the package does not yet expose a
dedicated property wrapper.

## Topics

### Getting Started

- <doc:Building-Stylesheets>
- <doc:Architecture>
- <doc:CSS-Properties>
- <doc:Rendering-CSS>
- <doc:Embedded-Compatibility>
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
- ``Cursor``
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
- ``ObjectFit``
- ``Opacity``
- ``Outline``
- ``Overflow``
- ``Padding``
- ``PointerEvents``
- ``Position``
- ``Resize``
- ``Right``
- ``RowGap``
- ``ScrollMarginTop``
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
- ``CursorValue``
- ``DisplayValue``
- ``FlexWrapValue``
- ``JustifyContentValue``
- ``ObjectFitValue``
- ``OutlineValue``
- ``OverflowValue``
- ``PointerEventsValue``
- ``PositionValue``
- ``ResizeValue``
- ``TextAlignValue``
- ``TextDecorationValue``
- ``TextTransformValue``
- ``CSSColorSchemePreference``
- ``CSSReducedMotionPreference``

### Rendering

- ``CSSNode``
- ``CSSNodeConvertible``
- ``CSSDeclaration``
- ``CSSDeclarationConvertible``
- ``CSSRenderable``
- ``CSSRendererProtocol``
- ``CSSStringRenderer``
- ``CSSTreeDumpRenderer``
- ``CSSRenderOptions``
