# Rendering CSS

Render SwiftCSS values to pretty-printed or compact CSS.

## Overview

Any type conforming to ``CSSRenderable`` can render itself with the convenience
APIs provided by SwiftCSS.

```swift
let stylesheet = StyleSheet {
    Rule(.class("card")) {
        Display(.flex)
        Padding(.px(24))
    }
}

let pretty = stylesheet.render()
let compact = stylesheet.render(prettyPrinted: false)
```

For custom output settings, pass ``CSSRenderOptions``. Pretty output uses four
spaces by default, but the indentation string is configurable.

```swift
let css = stylesheet.render(
    options: CSSRenderOptions(
        prettyPrinted: true,
        indentation: "  "
    )
)
```

Use ``CSSRenderer`` directly when integrating a custom ``CSSOutputStream``.
Most code can call the `render` convenience methods instead.

## Topics

### Renderable Values

- ``CSSRenderable``
- ``CSSProperty``

### Renderer Configuration

- ``CSSRenderOptions``
- ``CSSRenderContext``
- ``CSSRenderer``

### Output Streams

- ``CSSOutputStream``
- ``CSSStringOutputStream``
