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
    BackgroundColor(.hex("ffffff"))
    BorderRadius(.px(12))
}
```

Use typed values when the package provides them, for example ``Length``,
``Percentage``, ``Color``, and ``DisplayValue``. Use strings for CSS
functions, shorthand values, custom values, or newer CSS syntax that has not
yet received a dedicated SwiftCSS type.

```swift
Rule(.class("hero")) {
    Padding("clamp(2rem, 8vw, 6rem)")
    Transform("translateY(-2px)")
    RawProperty("--accent", "#f97316")
}
```

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

### Sizing and Spacing

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

### Grid and Flexbox

- ``GridTemplateColumns``
- ``GridTemplateRows``
- ``FlexWrap``
- ``AlignItems``
- ``JustifyContent``

### Typography

- ``FontFamily``
- ``FontSize``
- ``FontWeight``
- ``LineHeight``
- ``LetterSpacing``
- ``TextTransform``
- ``TextAlign``
- ``TextDecoration``

### Color, Borders, and Effects

- ``Color``
- ``BackgroundColor``
- ``Border``
- ``BorderColor``
- ``BorderRadius``
- ``BorderStyle``
- ``BorderWidth``
- ``Opacity``
- ``BoxShadow``
- ``BackdropFilter``

### Motion and Transforms

- ``Transform``
- ``Transition``
- ``TransitionDuration``

### Escape Hatch

- ``RawProperty``
- ``CSSProperty``
