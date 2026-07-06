# Rendering CSS

Render SwiftCSS model values to CSS text or debug output.

## Overview

SwiftCSS model values can be rendered with the convenience APIs provided by the
package. These APIs delegate to ``CSSStringRenderer``.

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

Use ``CSSStringRenderer`` directly when you want an explicit renderer value.

```swift
let renderer = CSSStringRenderer(
    options: CSSRenderOptions(prettyPrinted: false)
)

let css = renderer.render(stylesheet)
```

Use ``CSSTreeDumpRenderer`` when you need stable debug output from the same CSS
model.

```swift
let dump = CSSTreeDumpRenderer().render(stylesheet)
```

Custom renderers can conform to ``CSSRendererProtocol`` and traverse the same
``StyleSheet`` and ``Rule`` data.

## Topics

### Model Values

- ``CSSRenderable``
- ``CSSProperty``

### Renderers

- ``CSSRendererProtocol``
- ``CSSStringRenderer``
- ``CSSTreeDumpRenderer``

### Renderer Configuration

- ``CSSRenderOptions``
