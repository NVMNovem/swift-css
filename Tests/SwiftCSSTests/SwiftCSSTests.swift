import Testing
@testable import SwiftCSS

@Test func genericCSSDataTypesRenderRawValues() {
    #expect(CSSPercentage.percent(50).rawValue == "50%")
    #expect(CSSLength.px(24).rawValue == "24px")
    #expect(CSSLength.vh(100).rawValue == "100vh")
    #expect(CSSLength.fr(1).rawValue == "1fr")
    #expect(CSSColor.hex("0f1117").rawValue == "#0f1117")
    #expect(CSSTime.milliseconds(180).rawValue == "180ms")
    #expect(CSSAngle.deg(45).rawValue == "45deg")
}

@Test func propertySpecificValuesRenderRawValues() {
    #expect(DisplayValue.flex.rawValue == "flex")
    #expect(PositionValue.absolute.rawValue == "absolute")
    #expect(FontWeight.Value.weight(700).rawValue == "700")
    #expect(Color(.white).value == "white")
}

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
