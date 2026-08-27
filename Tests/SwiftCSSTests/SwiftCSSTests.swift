import Testing
@testable import SwiftCSS

private func requirePropertyType<Property: CSSProperty>(_: Property.Type) {}

@Test func publicPropertyStructsLowerToConcreteDeclarations() {
    requirePropertyType(Width.self)
    requirePropertyType(Color.self)
    requirePropertyType(Display.self)
    requirePropertyType(Padding.self)

    switch Width(.px(12)).cssDeclaration {
    case let .property(declaration):
        #expect(declaration.property == "width")
        #expect(declaration.value == "12px")
    case .raw:
        Issue.record("Width must lower as a typed declaration")
    }

    switch RawProperty("--accent", "#09f").cssDeclaration {
    case .property:
        Issue.record("RawProperty must lower as a raw declaration")
    case let .raw(declaration):
        #expect(declaration.property == "--accent")
        #expect(declaration.value == "#09f")
    }
}

@Test func publicDSLLowersToConcreteAST() {
    let stylesheet = StyleSheet {
        Rule(.class("button"), .hover) {
            Display(.flex)
            Padding(.px(12))
        }
    }

    guard case let .stylesheet(root) = stylesheet.cssNode,
          case let .rule(rule) = root.children.first else {
        Issue.record("Expected a stylesheet containing a concrete rule node")
        return
    }

    #expect(rule.declarations.count == 2)
    #expect(rule.selector.selectors.count == 1)
    #expect(rule.selector.selectors[0].head.selectors.count == 2)
}

@Test func concreteASTRendersThroughBothRenderers() {
    let selector = CSSSelectorNode(
        selectors: [
            .init(
                head: .init(selectors: [.class("button")]),
                tail: []
            )
        ]
    )
    let ast = CSSNode.stylesheet(
        .init(
            children: [
                .rule(
                    .init(
                        selector: selector,
                        declarations: [
                            .property(.init(property: "display", value: "flex"))
                        ]
                    )
                )
            ]
        )
    )

    #expect(CSSStringRenderer(options: .init(prettyPrinted: false)).render(ast) == ".button {display:flex;}")
    #expect(
        CSSTreeDumpRenderer().render(ast) == """
        Stylesheet
        └─ Rule
           ├─ selector: .button
           └─ display: flex
        """
    )
}

@Test func concreteBuildersSupportConditionalsAndArrays() {
    let includeColor = true
    let lengths = [Length.px(8), .px(12)]
    let selectors = ["one", "two"]

    let stylesheet = StyleSheet {
        for selector in selectors {
            Rule(.class(selector)) {
                if includeColor {
                    Color("var(--accent)")
                }

                for length in lengths {
                    Padding(length)
                }
            }
        }
    }

    #expect(
        stylesheet.render(prettyPrinted: false) == ".one {color:var(--accent);padding:8px;padding:12px;}.two {color:var(--accent);padding:8px;padding:12px;}"
    )
}

@Test func genericCSSDataTypesRenderRawValues() {
    #expect(Percentage.percent(50).rawValue == "50%")
    #expect(Length.px(24).rawValue == "24px")
    #expect(Length.percent(100).rawValue == "100%")
    #expect(Length.percent(12.5).rawValue == "12.5%")
    #expect(Length.auto.rawValue == "auto")
    #expect(Length.vh(100).rawValue == "100vh")
    #expect(Length.fr(1).rawValue == "1fr")
    #expect(Color.hex("0f1117").rawValue == "#0f1117")
    #expect(Color.css("var(--panel)").rawValue == "var(--panel)")
    #expect(Color.clear.rawValue == "transparent")
    #expect(Time.milliseconds(180).rawValue == "180ms")
    #expect(Angle.deg(45).rawValue == "45deg")
}

@Test func propertySpecificValuesRenderRawValues() {
    #expect(DisplayValue.flex.rawValue == "flex")
    #expect(PositionValue.absolute.rawValue == "absolute")
    #expect(FontWeight.Value.weight(700).rawValue == "700")
    #expect(LineHeightValue.normal.rawValue == "normal")
    #expect(LineHeightValue.multiple(1.7).rawValue == "1.7")
    #expect(LineHeightValue.multiple(1).rawValue == "1")
    #expect(LineHeightValue.length(.px(28)).rawValue == "28px")
    #expect(LineHeightValue.length(.rem(1.5)).rawValue == "1.5rem")
    #expect(LineHeightValue.percent(170).rawValue == "170%")
    #expect(Color(.white).value == "white")
    #expect(Color("#fff").render(prettyPrinted: false) == "color:#fff;")
    #expect(Color(.clear).render(prettyPrinted: false) == "color:transparent;")
    #expect(BackgroundColor(.css("var(--panel)")).render(prettyPrinted: false) == "background-color:var(--panel);")
    #expect(Width(.percent(100)).render(prettyPrinted: false) == "width:100%;")
    #expect(Height(.auto).render(prettyPrinted: false) == "height:auto;")
}

@Test func lineHeightValuesRenderExactDeclarations() {
    #expect(LineHeight(.normal).render() == "line-height: normal;")
    #expect(LineHeight(.multiple(1.7)).render() == "line-height: 1.7;")
    #expect(LineHeight(.multiple(1)).render() == "line-height: 1;")
    #expect(LineHeight(.length(.px(28))).render() == "line-height: 28px;")
    #expect(LineHeight(.length(.rem(1.5))).render() == "line-height: 1.5rem;")
    #expect(LineHeight(.percent(170)).render() == "line-height: 170%;")
    #expect(LineHeight(.multiple(1.7)).render(prettyPrinted: false) == "line-height:1.7;")
}

@Test func lineHeightLowersToConcreteASTAndTreeDump() {
    switch LineHeight(.multiple(1.7)).cssDeclaration {
    case let .property(declaration):
        #expect(declaration.property == "line-height")
        #expect(declaration.value == "1.7")
    case .raw:
        Issue.record("LineHeight must lower as a typed declaration")
    }

    let stylesheet = StyleSheet {
        Rule(.class("copy")) {
            LineHeight(.multiple(1.7))
        }
    }

    #expect(
        CSSTreeDumpRenderer().render(stylesheet) == """
        Stylesheet
        └─ Rule
           ├─ selector: .copy
           └─ line-height: 1.7
        """
    )
}

#if SWIFTCSS_ENABLE_STRING_LITERALS
@Test func lineHeightSupportsOptInStringLiterals() {
    #expect(LineHeight("var(--line-height)").render() == "line-height: var(--line-height);")
    let value: LineHeightValue = "1.7"
    #expect(LineHeight(value).render() == "line-height: 1.7;")
}
#endif

@Test func firstClassPropertiesRenderPrettyCSS() {
    let stylesheet = StyleSheet {
        Rule(.class("card")) {
            Display(.flex)
            Position(.relative)
            Width(.percent(100))
            BackgroundColor(.hex("0f1117"))
            Padding(.px(24))
            FontWeight(.weight(700))
        }
    }
    
    #expect(
        stylesheet.render() == """
        .card {
            display: flex;
            position: relative;
            width: 100%;
            background-color: #0f1117;
            padding: 24px;
            font-weight: 700;
        }
        """
    )
}

@Test func flexItemPropertiesRenderCSS() {
    #expect(AlignSelf(.auto).render() == "align-self: auto;")
    #expect(AlignSelf(.center).render() == "align-self: center;")
    #expect(FlexGrow(0).render() == "flex-grow: 0;")
    #expect(FlexShrink(1).render() == "flex-shrink: 1;")
    #expect(FlexBasis(.auto).render() == "flex-basis: auto;")
    #expect(FlexBasis(.percent(50)).render() == "flex-basis: 50%;")
}

@Test func firstClassPropertiesRenderCompactCSS() {
    let stylesheet = StyleSheet {
        Rule(.class("card")) {
            Display(.flex)
            Position(.relative)
            Width(.percent(100))
            BackgroundColor(.hex("0f1117"))
            Padding(.px(24))
            FontWeight(.weight(700))
        }
    }
    
    #expect(
        stylesheet.render(prettyPrinted: false) == ".card {display:flex;position:relative;width:100%;background-color:#0f1117;padding:24px;font-weight:700;}"
    )
}

@Test func selectorPartsRenderSimpleSelectors() {
    #expect(Rule(.class("hero")) { Display(.grid) }.render(prettyPrinted: false) == ".hero {display:grid;}" )
    #expect(Rule(.id("title")) { Display(.grid) }.render(prettyPrinted: false) == "#title {display:grid;}" )
    #expect(Rule(.element("body")) { Display(.grid) }.render(prettyPrinted: false) == "body {display:grid;}" )
    #expect(Rule(.root) { Display(.grid) }.render(prettyPrinted: false) == ":root {display:grid;}" )
    #expect(Rule(.universal) { Display(.grid) }.render(prettyPrinted: false) == "* {display:grid;}" )
}

@Test func selectorPartsRenderCompoundSelectors() {
    #expect(Rule(.class("button"), .class("primary")) { Display(.grid) }.render(prettyPrinted: false) == ".button.primary {display:grid;}" )
    #expect(Rule(.class("button"), .hover) { Display(.grid) }.render(prettyPrinted: false) == ".button:hover {display:grid;}" )
}

@Test func selectorPartsRenderComplexSelectors() {
    #expect(Rule(.class("card"), .descendant(.element("h2"))) { Display(.grid) }.render(prettyPrinted: false) == ".card h2 {display:grid;}" )
    #expect(Rule(.class("nav"), .child(.element("a"))) { Display(.grid) }.render(prettyPrinted: false) == ".nav > a {display:grid;}" )
    #expect(Rule(.element("h2"), .adjacentSibling(.element("p"))) { Display(.grid) }.render(prettyPrinted: false) == "h2 + p {display:grid;}" )
    #expect(Rule(.element("h2"), .generalSibling(.element("p"))) { Display(.grid) }.render(prettyPrinted: false) == "h2 ~ p {display:grid;}" )
}

@Test func ruleListRendersSelectorLists() {
    let rule = Rule.list(
        [
            [.element("h1")],
            [.element("h2")],
            [.element("h3")]
        ]
    ) {
        FontWeight(.weight(700))
    }
    
    #expect(
        rule.render(prettyPrinted: false) == "h1, h2, h3 {font-weight:700;}"
    )
}

@Test func portfolioPrimitivesRenderPropertyValues() {
    #expect(BoxSizing(.borderBox).render(prettyPrinted: false) == "box-sizing:border-box;")
    #expect(Gap(.px(28)).render(prettyPrinted: false) == "gap:28px;")
    #expect(MinHeight(.vh(100)).render(prettyPrinted: false) == "min-height:100vh;")
    #expect(GridTemplateColumns("repeat(3, minmax(0, 1fr))").render(prettyPrinted: false) == "grid-template-columns:repeat(3, minmax(0, 1fr));")
    #expect(Transform("translateY(-2px)").render(prettyPrinted: false) == "transform:translateY(-2px);")
    #expect(Transition("transform 180ms ease").render(prettyPrinted: false) == "transition:transform 180ms ease;")
    #expect(TransitionDuration(.seconds(0.2)).render(prettyPrinted: false) == "transition-duration:0.2s;")
}

@Test func visualModifierPropertiesRenderCSS() {
    #expect(Overflow(.hidden).render() == "overflow: hidden;")
    #expect(Overflow(.visible).render() == "overflow: visible;")
    #expect(Overflow(.scroll).render() == "overflow: scroll;")
    #expect(Overflow(.auto).render() == "overflow: auto;")
    
    #expect(ObjectFit(.cover).render() == "object-fit: cover;")
    #expect(ObjectFit(.contain).render() == "object-fit: contain;")
    #expect(ObjectFit(.fill).render() == "object-fit: fill;")
    #expect(ObjectFit(.none).render() == "object-fit: none;")
    #expect(ObjectFit(.scaleDown).render() == "object-fit: scale-down;")
    #expect(ObjectPosition("top right").render() == "object-position: top right;")
    
    #expect(AspectRatio(1.5).render() == "aspect-ratio: 1.5;")
    #expect(AspectRatio(3, 2).render() == "aspect-ratio: 3 / 2;")
    #expect(AspectRatio("auto").render() == "aspect-ratio: auto;")
    
    #expect(PointerEvents(.none).render() == "pointer-events: none;")
    #expect(PointerEvents(.auto).render() == "pointer-events: auto;")
    
    #expect(Cursor(.pointer).render() == "cursor: pointer;")
    #expect(Cursor(.default).render() == "cursor: default;")
    #expect(Cursor(.text).render() == "cursor: text;")
    #expect(Cursor(.notAllowed).render() == "cursor: not-allowed;")
    #expect(Cursor(.grab).render() == "cursor: grab;")
    #expect(Cursor(.grabbing).render() == "cursor: grabbing;")
    
    #expect(Resize(.none).render() == "resize: none;")
    #expect(Resize(.both).render() == "resize: both;")
    #expect(Resize(.horizontal).render() == "resize: horizontal;")
    #expect(Resize(.vertical).render() == "resize: vertical;")
    
    #expect(Outline(.none).render() == "outline: none;")
    #expect(ScrollMarginTop(.px(84)).render() == "scroll-margin-top: 84px;")
}

@Test func typographyPropertiesRenderCSS() {
    #expect(TextTransform(.uppercase).render() == "text-transform: uppercase;")
    #expect(TextTransform(.lowercase).render() == "text-transform: lowercase;")
    #expect(TextTransform(.capitalize).render() == "text-transform: capitalize;")
    #expect(TextTransform(.none).render() == "text-transform: none;")
    #expect(TextAlign(.left).render() == "text-align: left;")
    #expect(TextAlign(.center).render() == "text-align: center;")
    #expect(TextAlign(.right).render() == "text-align: right;")
    #expect(TextAlign(.justify).render() == "text-align: justify;")
    #expect(TextDecoration(.overline).render() == "text-decoration: overline;")
    #expect(WordBreak(.normal).render() == "word-break: normal;")
    #expect(WordBreak(.breakAll).render() == "word-break: break-all;")
    #expect(WordBreak(.keepAll).render() == "word-break: keep-all;")
    #expect(WordBreak(.breakWord).render() == "word-break: break-word;")
}

@Test func sidePropertiesRenderCSS() {
    #expect(MarginTop(.px(8)).render() == "margin-top: 8px;")
    #expect(MarginBottom(.px(5)).render() == "margin-bottom: 5px;")
    #expect(MarginLeft(.px(12)).render() == "margin-left: 12px;")
    #expect(MarginRight(.px(12)).render() == "margin-right: 12px;")
    #expect(MarginBottom("var(--space)").render() == "margin-bottom: var(--space);")
    
    #expect(BorderTop("1px solid red").render() == "border-top: 1px solid red;")
    #expect(BorderBottom("1px solid var(--line)").render() == "border-bottom: 1px solid var(--line);")
    #expect(BorderLeft("3px solid red").render() == "border-left: 3px solid red;")
    #expect(BorderRight("1px dashed red").render() == "border-right: 1px dashed red;")
}

@Test func mediaRuleRendersPrettyCSS() {
    let mediaRule = MediaRule(.maxWidth(.px(760))) {
        Rule(.element("main")) {
            Padding("24px 0")
        }
        
        Rule(.class("cards")) {
            GridTemplateColumns("1fr")
        }
    }
    
    #expect(
        mediaRule.render() == """
        @media (max-width: 760px) {
            main {
                padding: 24px 0;
            }

            .cards {
                grid-template-columns: 1fr;
            }
        }
        """
    )
}

@Test func mediaRuleRendersCompactCSS() {
    let mediaRule = MediaRule(.maxWidth(.px(760))) {
        Rule(.element("main")) {
            Padding("24px 0")
        }
        
        Rule(.class("cards")) {
            GridTemplateColumns("1fr")
        }
    }
    
    #expect(
        mediaRule.render(prettyPrinted: false) == "@media (max-width:760px) {main {padding:24px 0;}.cards {grid-template-columns:1fr;}}"
    )
}

@Test func mediaAliasRendersTypedColorSchemeCondition() {
    let media = Media(.prefersColorScheme(.dark)) {
        Rule(.root) {
            RawProperty("--text", "#fff")
        }
    }
    
    #expect(
        media.render() == """
        @media (prefers-color-scheme: dark) {
            :root {
                --text: #fff;
            }
        }
        """
    )
    
    #expect(
        media.render(prettyPrinted: false) == "@media (prefers-color-scheme:dark) {:root {--text:#fff;}}"
    )
}

@Test func mediaRuleRawConditionStillRenders() {
    let mediaRule = MediaRule(.raw("(prefers-color-scheme: dark)")) {
        Rule(.root) {
            RawProperty("--text", "#fff")
        }
    }
    
    #expect(
        mediaRule.render(prettyPrinted: false) == "@media (prefers-color-scheme: dark) {:root {--text:#fff;}}"
    )
}

@Test func nestedMediaRulesRender() {
    let media = Media(.maxWidth(.px(760))) {
        Media(.reducedMotion(.noPreference)) {
            Rule(.class("card")) {
                Transition("opacity 180ms ease")
            }
        }
    }
    
    #expect(
        media.render() == """
        @media (max-width: 760px) {
            @media (prefers-reduced-motion: no-preference) {
                .card {
                    transition: opacity 180ms ease;
                }
            }
        }
        """
    )
}

@Test func supportsRendersPropertyCondition() {
    let supports = Supports(.property("display", "grid")) {
        Rule(.class("layout")) {
            RawProperty("display", "grid")
        }
    }
    
    #expect(
        supports.render() == """
        @supports (display: grid) {
            .layout {
                display: grid;
            }
        }
        """
    )
    
    #expect(
        supports.render(prettyPrinted: false) == "@supports (display:grid) {.layout {display:grid;}}"
    )
}

@Test func supportsRendersTypedDisplayCondition() {
    let supports = Supports(.display(.grid)) {
        Rule(.class("layout")) {
            Display(.grid)
        }
    }
    
    #expect(
        supports.render(prettyPrinted: false) == "@supports (display:grid) {.layout {display:grid;}}"
    )
}

@Test func namedLayerRendersRules() {
    let layer = Layer("components") {
        Rule(.class("card")) {
            RawProperty("padding", "1rem")
        }
    }
    
    #expect(
        layer.render() == """
        @layer components {
            .card {
                padding: 1rem;
            }
        }
        """
    )
    
    #expect(
        layer.render(prettyPrinted: false) == "@layer components {.card {padding:1rem;}}"
    )
}

@Test func anonymousLayerRendersRules() {
    let layer = Layer {
        Rule(.class("reset")) {
            RawProperty("box-sizing", "border-box")
        }
    }
    
    #expect(
        layer.render() == """
        @layer {
            .reset {
                box-sizing: border-box;
            }
        }
        """
    )
}

@Test func layerOrderRendersDeclaration() {
    #expect(
        Layer.order("reset", "base", "components").render() == "@layer reset, base, components;"
    )
}

@Test func keyframesRenderPrettyCSS() {
    let keyframes = Keyframes("pulse") {
        Keyframe(.from) {
            RawProperty("opacity", "0")
        }
        
        Keyframe(.percent(50)) {
            RawProperty("opacity", "0.5")
        }
        
        Keyframe(.to) {
            RawProperty("opacity", "1")
        }
    }
    
    #expect(
        keyframes.render() == """
        @keyframes pulse {
            from {
                opacity: 0;
            }

            50% {
                opacity: 0.5;
            }

            to {
                opacity: 1;
            }
        }
        """
    )
}

@Test func keyframesRenderCompactCSS() {
    let keyframes = Keyframes("pulse") {
        Keyframe(.from) {
            RawProperty("opacity", "0")
        }
        
        Keyframe(.percent(50)) {
            RawProperty("opacity", "0.5")
        }
        
        Keyframe(.to) {
            RawProperty("opacity", "1")
        }
    }
    
    #expect(
        keyframes.render(prettyPrinted: false) == "@keyframes pulse {from {opacity:0;}50% {opacity:0.5;}to {opacity:1;}}"
    )
}

@Test func stylesheetRendersNewAtRuleDSL() {
    let stylesheet = StyleSheet {
        Media(.prefersColorScheme(.dark)) {
            Rule(.root) {
                RawProperty("--text", "#fff")
            }
        }
        
        Supports(.display(.grid)) {
            Rule(.class("layout")) {
                RawProperty("display", "grid")
            }
        }
        
        Layer("components") {
            Rule(.class("card")) {
                RawProperty("padding", "1rem")
            }
        }
        
        Keyframes("pulse") {
            Keyframe(.from) {
                RawProperty("opacity", "0")
            }
            
            Keyframe(.to) {
                RawProperty("opacity", "1")
            }
        }
    }
    
    #expect(
        stylesheet.render(prettyPrinted: false) == "@media (prefers-color-scheme:dark) {:root {--text:#fff;}}@supports (display:grid) {.layout {display:grid;}}@layer components {.card {padding:1rem;}}@keyframes pulse {from {opacity:0;}to {opacity:1;}}"
    )
}

@Test func cssStringRendererMatchesConvenienceRendering() {
    let stylesheet = StyleSheet {
        Rule(.class("card")) {
            Color(.css("var(--text)"))
            Width(.percent(100))
            Overflow(.hidden)
            GridTemplateColumns("repeat(2, minmax(0, 1fr))")
            TextTransform(.uppercase)
        }
        
        Media(.maxWidth(.px(760))) {
            Rule(.class("card")) {
                Width(.percent(100))
            }
        }
    }
    
    let renderer = CSSStringRenderer(options: .init(prettyPrinted: false))
    
    #expect(renderer.render(stylesheet) == stylesheet.render(prettyPrinted: false))
    #expect(renderer.render(Rule(.class("card")) { Width(.px(320)) }) == ".card {width:320px;}")
}

@Test func sameStylesheetCanRenderAsCSSAndTreeDump() {
    let stylesheet = StyleSheet {
        Rule(.class("button")) {
            Color(.css("var(--accent)"))
            Padding(.px(12))
        }
    }
    
    #expect(
        CSSStringRenderer(options: .init(prettyPrinted: false)).render(stylesheet) == ".button {color:var(--accent);padding:12px;}"
    )
    
    #expect(
        CSSTreeDumpRenderer().render(stylesheet) == """
        Stylesheet
        └─ Rule
           ├─ selector: .button
           ├─ color: var(--accent)
           └─ padding: 12px
        """
    )
}

@Test func treeDumpRendererRendersStableDebugTree() {
    let stylesheet = StyleSheet {
        Rule(.class("button"), .hover) {
            RawProperty("--accent", "#09f")
            Overflow(.hidden)
        }
        
        Supports(.display(.grid)) {
            Rule(.class("layout")) {
                GridTemplateColumns("1fr 1fr")
            }
        }
        
        Media(.maxWidth(.px(760))) {
            Rule(.element("main")) {
                Width(.percent(100))
            }
        }
        
        Layer.order("reset", "components")
        
        Keyframes("fade") {
            Keyframe(.from) {
                RawProperty("opacity", "0")
            }
            
            Keyframe(.to) {
                RawProperty("opacity", "1")
            }
        }
    }
    
    #expect(
        CSSTreeDumpRenderer().render(stylesheet) == """
        Stylesheet
        ├─ Rule
        │  ├─ selector: .button:hover
        │  ├─ --accent: #09f
        │  └─ overflow: hidden
        ├─ @supports (display: grid)
        │  └─ Rule
        │     ├─ selector: .layout
        │     └─ grid-template-columns: 1fr 1fr
        ├─ @media (max-width: 760px)
        │  └─ Rule
        │     ├─ selector: main
        │     └─ width: 100%
        ├─ @layer reset, components;
        └─ @keyframes fade
           ├─ Keyframe from
           │  └─ opacity: 0
           └─ Keyframe to
              └─ opacity: 1
        """
    )
}
