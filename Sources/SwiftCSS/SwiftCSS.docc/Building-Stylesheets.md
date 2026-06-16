# Building Stylesheets

Compose selectors, declarations, and at-rules with Swift result builders.

## Overview

Start with ``StyleSheet`` and add top-level ``Rule`` values. A rule takes one or
more ``SelectorPart`` values and a property builder body.

```swift
let stylesheet = StyleSheet {
    Rule(.element("body")) {
        Margin(.zero)
        FontFamily("system-ui, sans-serif")
        Color(.hex("111827"))
    }

    Rule(.class("button"), .hover) {
        Transform("translateY(-1px)")
    }
}
```

Create selector lists with ``Rule/list(_:properties:)`` when multiple selectors
share the same declarations.

```swift
let headings = Rule.list(
    [
        [.element("h1")],
        [.element("h2")],
        [.element("h3")]
    ]
) {
    FontWeight(.weight(700))
}
```

Use at-rule nodes wherever a stylesheet-level renderable is accepted.

```swift
let responsive = StyleSheet {
    Media(.maxWidth(.px(760))) {
        Rule(.class("cards")) {
            GridTemplateColumns("1fr")
        }
    }

    Supports(.display(.grid)) {
        Rule(.class("layout")) {
            Display(.grid)
        }
    }

    Layer("components") {
        Rule(.class("card")) {
            Padding(.rem(1))
        }
    }
}
```

## Topics

### Stylesheet Root

- ``StyleSheet``
- ``CSSBuilder``

### Rules and Selectors

- ``Rule``
- ``SelectorPart``
- ``CSSPropertyBuilder``

### Conditional and Layered CSS

- ``Media``
- ``MediaCondition``
- ``Supports``
- ``SupportsCondition``
- ``Layer``
- ``LayerOrder``

### Animations

- ``Keyframes``
- ``Keyframe``
- ``KeyframeSelector``
