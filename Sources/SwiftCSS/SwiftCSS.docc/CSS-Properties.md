# CSS Properties

Browse the first-class CSS declaration wrappers exposed by SwiftCSS.

## Overview

Every first-class CSS declaration type conforms to ``CSSProperty``. The wrapper
sets a fixed CSS property name and accepts a typed SwiftCSS value, a raw string,
or both, depending on the property.

```swift
Rule(.class("panel")) {
    Display(.grid)
    GridTemplateColumns("repeat(3, minmax(0, 1fr))")
    Gap(.px(24))
    Width(.percent(100))
    Height(.auto)
    BackgroundColor(.css("var(--panel)"))
    BorderColor(.clear)
    BorderRadius(.px(12))
}
```

Use typed values when the package provides them, for example ``Length``,
``Percentage``, ``Color``, ``DisplayValue``, and ``LineHeightValue``. Use strings for CSS
functions, shorthand values, custom values, or newer CSS syntax that has not
yet received a dedicated SwiftCSS type.

```swift
Rule(.class("hero")) {
    LineHeight(.multiple(1.7))
    Padding("clamp(2rem, 8vw, 6rem)")
    Transform("translateY(-2px)")
    RawProperty("--accent", "#f97316")
}
```

Unitless `line-height` is a multiplier, not a ``Length``. For example,
`LineHeight(.multiple(1.7))` scales the line box from the element's own font
size. This also inherits more predictably than a fixed `em` line height because
descendants apply the inherited multiplier to their own font size. Use
`LineHeight(.length(.px(28)))` for an explicit length or
`LineHeight(.percent(170))` for a percentage.

Code that previously used `LineHeight(1.7)`, `LineHeight("1.7")`, or optional
string-literal syntax should migrate to `LineHeight(.multiple(1.7))`. Raw CSS
remains available through `LineHeight(LineHeightValue("var(--line-height)"))`
or the property's string initializer.

## Topics

### Layout and Display

- ``Display``
- ``Position``
- ``Top``
- ``Right``
- ``Bottom``
- ``Left``
- ``Inset``
- ``ZIndex``
- ``BoxSizing``
- ``Overflow``
- ``ObjectFit``
- ``ObjectPosition``

### Sizing and Spacing

- ``AspectRatio``
- ``Width``
- ``Height``
- ``MinWidth``
- ``MinHeight``
- ``MaxWidth``
- ``MaxHeight``
- ``Margin``
- ``MarginTop``
- ``MarginBottom``
- ``MarginLeft``
- ``MarginRight``
- ``Padding``
- ``Gap``
- ``RowGap``
- ``ColumnGap``
- ``ScrollMarginTop``

### Grid and Flexbox

- ``GridTemplateColumns``
- ``GridTemplateRows``
- ``FlexWrap``
- ``AlignItems``
- ``AlignSelf``
- ``JustifyContent``
- ``FlexGrow``
- ``FlexShrink``
- ``FlexBasis``

### Typography

- ``FontFamily``
- ``FontSize``
- ``FontWeight``
- ``LineHeight``
- ``LineHeightValue``
- ``LetterSpacing``
- ``TextTransform``
- ``TextAlign``
- ``TextDecoration``
- ``TextOverflow``
- ``TextOverflowValue``
- ``WhiteSpace``
- ``WhiteSpaceValue``
- ``WordBreak``
- ``WordBreakValue``

### Color, Borders, and Effects

- ``Color``
- ``BackgroundColor``
- ``Border``
- ``BorderTop``
- ``BorderBottom``
- ``BorderLeft``
- ``BorderRight``
- ``BorderColor``
- ``BorderRadius``
- ``BorderStyle``
- ``BorderWidth``
- ``Outline``
- ``Opacity``
- ``BoxShadow``
- ``BackdropFilter``

### Interaction

- ``PointerEvents``
- ``Cursor``
- ``Resize``

### Motion and Transforms

- ``Transform``
- ``Transition``
- ``TransitionDuration``

### Escape Hatch

- ``RawProperty``
- ``CSSProperty``
