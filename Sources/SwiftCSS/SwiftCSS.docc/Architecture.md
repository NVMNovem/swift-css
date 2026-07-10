# Architecture

Understand the boundary between SwiftCSS's typed authoring API and its concrete
renderer model.

## Overview

SwiftCSS uses two layers:

```text
Public SwiftCSS DSL
        ↓
Concrete CSS AST
        ↓
CSSStringRenderer
CSSTreeDumpRenderer
Future CSSOMRenderer
```

The public DSL preserves types such as ``StyleSheet``, ``Rule``, ``Width``,
``Color``, ``Display``, selectors, at-rules, and typed CSS values. These types
lower through ``CSSNodeConvertible`` or ``CSSDeclarationConvertible``.

The concrete renderer model is rooted at ``CSSNode``. It contains concrete
stylesheet, rule, at-rule, declaration, condition, keyframe, and selector
values. ``CSSBuilder`` and ``CSSPropertyBuilder`` lower expressions immediately
and return concrete arrays.

Renderers accept only ``CSSNode``. ``CSSStringRenderer`` owns all CSS syntax and
formatting, while ``CSSTreeDumpRenderer`` proves that the same AST supports a
different output. Future renderers such as a CSSOM renderer can traverse this
same exhaustive model.

This separation avoids existential storage, dynamic casting, and reflection;
preserves typed CSS ergonomics; and satisfies Embedded Swift's restrictions.
